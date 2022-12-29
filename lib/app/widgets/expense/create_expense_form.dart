import 'package:flutter/material.dart';

class CreateExpenseForm extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController desc;
  const CreateExpenseForm({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          validator: (value) => value != null && value.isEmpty
              ? "Cannot have a empty title"
              : null,
          controller: title,
          maxLength: 50,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            helperText: 'Maximum 50 characters ',
            hintText: 'Title',
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: desc,
          maxLines: 3,
          maxLength: 250,
          decoration: const InputDecoration(
            helperText: 'Maximum 250 characters',
            hintText: 'Description',
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
