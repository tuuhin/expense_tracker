import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/app/home/tabs/tabs.dart';
import 'package:expense_tracker/app/home/user/user_profile.dart';
import 'package:expense_tracker/app/widgets/home/home_background.dart';
import 'package:expense_tracker/app/widgets/tab_info.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  final AnimationController controller;
  const Home({Key? key, required this.controller}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentTab = 0;

  final List<TabInfo> _tabInfo = [
    TabInfo(
      icon: const Icon(Icons.home_outlined),
      tab: const MainTab(),
      label: 'Home',
    ),
    TabInfo(
      icon: const Icon(Icons.folder_copy),
      tab: const EntriesTab(),
      label: 'Entries',
    )
  ];

  void _openMenu() {
    if (widget.controller.status == AnimationStatus.completed) {
      widget.controller.reverse();
    } else {
      widget.controller.forward();
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
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabInfo.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openProfile() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const UserProfile(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _openMenu,
          icon: const FaIcon(FontAwesomeIcons.alignLeft),
        ),
        actions: [
          IconButton(
            onPressed: _openProfile,
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Hero(
                tag: 'profile_image',
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://media.gettyimages.com/photos/joe-root-of-england-celebrates-his-century-during-day-four-of-the-picture-id1030463034?s=2048x2048',
                    fadeInCurve: Curves.easeInBack,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<EntriesCubit>(
            create: (context) => EntriesCubit(),
          ),
        ],
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                foregroundPainter: BackGroundDesign(context),
              ),
            ),
            TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                // physics: _getScrollMode(),
                children: _tabInfo.map((e) => e.tab).toList()),
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //     color: Colors.white,
      //     shape: const CircularNotchedRectangle(),
      //     notchMargin: 5,
      //     child: SizedBox(
      //       height: 60,
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           IconButton(
      //               onPressed: () => _animateTabs(0),
      //               icon: const Icon(Icons.home)),
      //           IconButton(
      //               onPressed: () => _animateTabs(1),
      //               icon: const Icon(Icons.note)),
      //           const SizedBox(width: 20),
      //         ],
      //       ),
      //     )),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _animateTabs(index);
          setState(() => _currentTab = index);
        },
        selectedFontSize: Theme.of(context).textTheme.bodyText1!.fontSize ?? 20,
        currentIndex: _currentTab,
        unselectedFontSize:
            Theme.of(context).textTheme.bodyText2!.fontSize ?? 16,
        selectedIconTheme: const IconThemeData(size: 26),
        unselectedIconTheme: const IconThemeData(size: 22),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        selectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
        unselectedLabelStyle:
            const TextStyle(fontWeight: FontWeight.w400, fontSize: 11),
        showUnselectedLabels: true,
        items: _tabInfo
            .asMap()
            .map(
              (key, tab) => MapEntry(
                key,
                BottomNavigationBarItem(
                  icon: tab.icon,
                  label: tab.label,
                ),
              ),
            )
            .values
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButtonAnimator:,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        onPressed: _openMenu,
        child: const Icon(Icons.add),
      ),
    );
  }
}
