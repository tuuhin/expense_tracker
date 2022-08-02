import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({Key? key}) : super(key: key);

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .5,
      child: Card(
          child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            reminderImage,
            const SizedBox(height: 10),
            Text(
              'Reminder',
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      )),
    );
  }
}
