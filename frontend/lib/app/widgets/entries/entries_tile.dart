import 'package:flutter/material.dart';

class EntriesTitle extends StatelessWidget {
  final String title;
  final String? desc;
  final String type;
  const EntriesTitle({
    Key? key,
    required this.title,
    this.desc,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
              colors: [
                type == 'income'
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.4)
                    : Theme.of(context).colorScheme.secondary.withOpacity(0.4), 
                    Theme.of(context).cardColor,
              ]),
        ),
        child: ListTile(
          title: Text(title),
          subtitle: Text(desc ?? ''),
        ),
      ),
    );
  }
}
