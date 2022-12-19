import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../widgets/widgets.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  late ScrollController _controller;

  void _scrollCallBack() {
    double delta = MediaQuery.of(context).size.height * .2;
    if (_controller.position.maxScrollExtent - _controller.position.pixels <=
        delta) {
      context.read<NotificationBloc>().fetchMore();
    }
  }

  void _postFrameCallBack(Duration _) async {
    final int count = context.read<NotificationBloc>().itemCount;
    final GlobalKey<SliverAnimatedListState> key =
        context.read<NotificationBloc>().key;

    for (int i = 0; i < count; i++) {
      await Future.delayed(
        const Duration(milliseconds: 40),
        () => key.currentState?.insertItem(i),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollCallBack);
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallBack);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scrollbar(
      controller: _controller,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('Overview',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w700)),
                  ),
                  SizedBox(
                    height: size.height * .3,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ClientBaseInfomation(),
                    ),
                  ),
                ],
              ),
            ),
            const SliverToBoxAdapter(child: PlanningCards()),
          ],
        ),
      ),
    );
  }
}
