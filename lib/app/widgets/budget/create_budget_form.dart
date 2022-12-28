import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class CreateBudgetForm extends StatelessWidget {
  final DateTime fromDate;
  final DateTime toDate;

  final VoidCallback pickFromDate;
  final VoidCallback pickToDate;

  final TextEditingController title;
  final TextEditingController desc;
  final TextEditingController amount;

  const CreateBudgetForm({
    Key? key,
    required this.fromDate,
    required this.toDate,
    required this.pickFromDate,
    required this.pickToDate,
    required this.title,
    required this.desc,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TextFormField(
          validator: (value) => value != null && value.isEmpty
              ? 'Untitled budget cannot be created '
              : value != null && value.length < 5
                  ? 'Minimum 5 chars are reqired'
                  : null,
          controller: title,
          maxLength: 50,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
              helperText: 'Maximum of 50 lines allowed', hintText: 'Title'),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: desc,
          maxLength: 250,
          maxLines: 3,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
              helperText: 'Maximum 250 words allowed', hintText: 'Description'),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: const Text("FROM",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: pickFromDate,
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.date_range, color: Colors.white),
                ),
                title: Text(toSimpleDate(fromDate)),
              ),
              const Divider(height: 4),
              ListTile(
                onTap: pickToDate,
                trailing: const Text("TO",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                leading: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Icon(Icons.date_range, color: Colors.white),
                ),
                title: Text(toSimpleDate(toDate)),
              ),
            ],
          ),
        ),
        TextFormField(
          validator: (value) => value != null && value.isEmpty
              ? 'Amount should be greater than 0.0'
              : value != null && double.tryParse(value) == null
                  ? 'Please provide a amount not a bunch of characters'
                  : null,
          controller: amount,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Amount'),
        ),
        const Divider(),
      ],
    );
  }
}
