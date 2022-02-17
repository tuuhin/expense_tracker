import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainTab extends StatefulWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  Widget build(BuildContext context) {
    final double _screenY = MediaQuery.of(context).size.height;
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Text('Overview',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            SizedBox(
              height: _screenY * .3,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: [
                  DataCards(title: 'Total Salary', amount: 2908.90),
                  DataCards(title: 'Total Expense', amount: 2908.90),
                  DataCards(title: 'purchase', amount: 2908.90),
                  DataCards(title: 'purchase', amount: 2908.90),
                ],
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: _screenY * .2,
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                children: const [
                  ImportanceCard(icon: Icons.star, title: 'Savings'),
                  ImportanceCard(
                      icon: Icons.notifications_active, title: 'Reminders'),
                  ImportanceCard(icon: Icons.account_balance, title: 'Budget'),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              trailing: const Icon(Icons.more_vert),
              title: const Text('Latest entries'),
            )
          ],
        ),
      ),
    );
  }
}
