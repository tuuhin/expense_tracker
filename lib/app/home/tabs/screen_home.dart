import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/widgets.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  Future<void> _onRefresh() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Refresh Data'),
          content: const Text(
              'If you have some changes made in your income and expense please refresh to get new data'),
          actions: [
            TextButton(
              onPressed: () => context
                  .read<BaseInformationCubit>()
                  .refresh()
                  .then(Navigator.of(context).pop),
              child: const Text('Refresh'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Overview',
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 4),
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
