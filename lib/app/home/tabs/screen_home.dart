import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class MainTab extends StatelessWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    );
  }
}
