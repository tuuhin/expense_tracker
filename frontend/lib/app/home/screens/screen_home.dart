import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainTab extends StatelessWidget {
  const MainTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double _screenY = MediaQuery.of(context).size.height;
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView(
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
                children: const [
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
                children: [
                  ImportanceCard(
                    icon: Icons.star,
                    title: 'Savings',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Savings()));
                    },
                  ),
                  ImportanceCard(
                    icon: Icons.notifications_active,
                    title: 'Reminders',
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Reminders())),
                  ),
                  ImportanceCard(
                    icon: Icons.account_balance,
                    title: 'Budget',
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Budget())),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              trailing: const Icon(Icons.more_vert),
              title: const Text('Latest entries'),
            ),
          ],
        ),
      ),
    );
  }
}
