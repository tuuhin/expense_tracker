import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:flutter/material.dart';

class Reminders extends StatelessWidget {
  const Reminders({Key? key}) : super(key: key);
  final OutlinedBorder _bottomSheetBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  void _addNewReminder(BuildContext context) => showModalBottomSheet(
      shape: _bottomSheetBorder,
      context: context,
      builder: (context) => const AddReminder());

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Reminders'),
          backgroundColor: Colors.transparent,
          elevation: 0),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const SizedBox(height: 80),
            const Divider(),
            const Spacer(),
            const Text('No Reminders'),
            const Spacer(),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(_size.width, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                onPressed: () => _addNewReminder(context),
                child: Text('Add a reminder',
                    style: Theme.of(context).textTheme.subtitle1)),
          ])),
    );
  }
}
