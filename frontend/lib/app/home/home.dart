import 'package:expense_tracker/app/home/screens/screens.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final AnimationController controller;
  const Home({Key? key, required this.controller}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> _screens = const [
    MainTab(),
    StatisticsTab(),
    EntriesTab(),
    ProfileTab(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openMenu() {
    if (widget.controller.status == AnimationStatus.completed) {
      widget.controller.reverse();
    } else {
      widget.controller.forward();
    }
  }

  void _closeMenu() {
    if (widget.controller.status == AnimationStatus.completed) {
      widget.controller.reverse();
    }
  }

  ScrollPhysics _getScrollMode() {
    if (widget.controller.status == AnimationStatus.completed) {
      return const NeverScrollableScrollPhysics();
    } else {
      return const BouncingScrollPhysics();
    }
  }

  void _animateTabs(int tabNo) {
    if (!(widget.controller.status == AnimationStatus.completed)) {
      _tabController.animateTo(tabNo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeMenu,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _openMenu,
            icon: const Icon(Icons.menu),
          ),
          centerTitle: true,
          elevation: 0,
          title: const Text('hi world'),
        ),
        body: TabBarView(
            controller: _tabController,
            physics: _getScrollMode(),
            children: _screens),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () => _animateTabs(0),
                      icon: const Icon(Icons.home)),
                  IconButton(
                      onPressed: () => _animateTabs(1),
                      icon: const Icon(Icons.stacked_bar_chart)),
                  IconButton(
                      onPressed: () => _animateTabs(2),
                      icon: const Icon(Icons.note)),
                  IconButton(
                      onPressed: () => _animateTabs(3),
                      icon: const Icon(Icons.person))
                ],
              ),
            )
            // child: BottomNavigationBar(items: const [
            //   BottomNavigationBarItem(icon: Icon(Icons.add), label: 'tuhin'),
            //   BottomNavigationBarItem(icon: Icon(Icons.add), label: 'boy')
            // ]),
            ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: _openMenu,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
