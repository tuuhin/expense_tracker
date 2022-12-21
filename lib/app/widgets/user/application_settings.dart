import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ApplicationSettings extends StatefulWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  State<ApplicationSettings> createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  void _showIncomes() => context.push('/income');
  void _showSources() => context.push('/sources');
  void _showCategories() => context.push('/categories');
  void _showExpenses() => context.push('/expenes');

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
              const ListTile(title: Text('Application')),
              const Divider(height: 1, color: Colors.grey),
              ListTile(
                onTap: _showIncomes,
                title: const Text('Income'),
                leading: Image.asset("assets/icons/profits.png"),
              ),
              // const Divider(),
              ListTile(
                onTap: _showExpenses,
                title: const Text('Expense'),
                leading: Image.asset("assets/icons/expenses.png"),
              ),
              ListTile(
                onTap: _showSources,
                title: const Text('Source'),
                leading: Image.asset("assets/icons/block.png"),
              ),
              ListTile(
                onTap: _showCategories,
                title: const Text('Categories'),
                leading: Image.asset("assets/icons/category.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
