import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../context/context.dart';
import '../widgets/widgets.dart';

import './tabs/tabs.dart';

class TabInfo {
  final Widget tab;
  final Widget icon;
  final String label;
  const TabInfo({required this.icon, required this.tab, required this.label});
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _currentTab = 0;

  final List<TabInfo> _tabInfo = const [
    TabInfo(
      icon: Icon(Icons.home_outlined),
      tab: MainTab(),
      label: 'Home',
    ),
    TabInfo(
      icon: Icon(Icons.folder_copy),
      tab: EntriesTab(),
      label: 'Entries',
    ),
    TabInfo(
      icon: Icon(Icons.notifications),
      tab: NotificationTab(),
      label: "Notifications",
    )
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabInfo.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<EntriesBloc>().init();
    context.read<NotificationBloc>().init();
    context.read<BaseInformationCubit>().getBaseOverView();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _openProfile() => context.push('/settings');

  void _tabViewOnTap(int index) {
    _tabController.animateTo(index);
    setState(() => _currentTab = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        leading: IconButton(
            onPressed: () {}, icon: const FaIcon(FontAwesomeIcons.alignLeft)),
        actions: [
          IconButton(
            onPressed: _openProfile,
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: const Hero(
                tag: 'profile_image',
                child: AsyncProfileImage(),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          const HomeBackground(),
          TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              // physics: _getScrollMode(),
              children: _tabInfo.map((e) => e.tab).toList()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        onTap: _tabViewOnTap,
        selectedFontSize: Theme.of(context).textTheme.bodyText1!.fontSize ?? 20,
        currentIndex: _currentTab,
        unselectedFontSize:
            Theme.of(context).textTheme.bodyText2?.fontSize ?? 16,
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
                BottomNavigationBarItem(icon: tab.icon, label: tab.label),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
