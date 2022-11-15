import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationSettings extends StatelessWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8, right: 8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(dense: true, title: Text('Application')),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () => Navigator.of(context).push(
                  appRouteBuilder(const ShowIncomes()),
                ),
                title: const Text('Income'),
                leading: const FaIcon(FontAwesomeIcons.moneyBillWave),
              ),
              // const Divider(),
              ListTile(
                onTap: () => Navigator.of(context).push(
                  appRouteBuilder(const ShowExpenses()),
                ),
                title: const Text('Expense'),
                leading: const FaIcon(FontAwesomeIcons.moneyCheck),
              ),

              ListTile(
                  onTap: () => Navigator.of(context).push(
                        appRouteBuilder(const ShowIncomeSources()),
                      ),
                  title: const Text('Source'),
                  leading: const FaIcon(FontAwesomeIcons.productHunt)),

              ListTile(
                  onTap: () => Navigator.of(context).push(
                        appRouteBuilder(const ShowExpenseCategories()),
                      ),
                  title: const Text('Categories'),
                  leading: const FaIcon(FontAwesomeIcons.buyNLarge)),
            ],
          ),
        ),
      ),
    );
  }
}
