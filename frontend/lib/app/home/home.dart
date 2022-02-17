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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            onPressed: _openMenu,
            icon: Icon(Icons.menu,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SizedBox.expand(
                child: CustomPaint(
              foregroundPainter: BackGroundDesign(),
            )),
            TabBarView(
                controller: _tabController,
                physics: _getScrollMode(),
                children: _screens),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Container(
              color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      icon: const Icon(Icons.person)),
                  const SizedBox(width: 20),
                ],
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: _openMenu,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class BackGroundDesign extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..strokeWidth = 10
      ..color = Color(0xffd5d5d5)
      ..style = PaintingStyle.fill;

    Path _path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(size.width * 0.65, size.height * 0.2, size.width * 0.45,
          size.height * 0.6, 0, size.height * 0.5)
      ..lineTo(0, 0);

    canvas.drawPath(_path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
