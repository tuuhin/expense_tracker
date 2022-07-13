import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ApplicationSettings extends StatefulWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  State<ApplicationSettings> createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(dense: true, title: Text('Application')),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {},
                title: const Text('Income'),
                leading: const FaIcon(FontAwesomeIcons.moneyBillWave),
              ),
              // const Divider(),
              ListTile(
                onTap: () {},
                title: const Text('Expense'),
                leading: const FaIcon(FontAwesomeIcons.moneyCheck),
              ),

              ListTile(
                  onTap: () => {},
                  title: const Text('Source'),
                  leading: const FaIcon(FontAwesomeIcons.productHunt)),

              ListTile(
                  onTap: () => {},
                  title: const Text('Categories'),
                  leading: const FaIcon(FontAwesomeIcons.buyNLarge)),
            ],
          ),
        ),
      ),
    );
  }
}
