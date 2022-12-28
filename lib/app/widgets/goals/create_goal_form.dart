import 'package:flutter/material.dart';

class CreateGoalForm extends StatelessWidget {
  final TextEditingController title;
  final TextEditingController desc;
  final TextEditingController price;
  final TextEditingController collected;

  const CreateGoalForm({
    Key? key,
    required this.title,
    required this.desc,
    required this.price,
    required this.collected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          validator: (value) =>
              value != null && value.isEmpty ? "Enter some title" : null,
          controller: title,
          keyboardType: TextInputType.name,
          decoration: const InputDecoration(
            hintText: 'Someday I will get that',
            labelText: 'Title',
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: desc,
          maxLines: 4,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            hintText: 'This is my only wish.I will someday have that',
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: 0.125,
            ),
            labelText: 'Goal Description',
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          validator: (value) => value != null && value.isEmpty
              ? 'Enter some price'
              : value != null && double.tryParse(value) == null
                  ? 'ENter valid number not characters'
                  : null,
          controller: price,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Actual Price',
            hintText: "500",
            prefixIcon: Icon(Icons.money),
          ),
        ),
        const SizedBox(height: 15),
        TextFormField(
          controller: collected,
          validator: (value) => value != null && double.tryParse(value) == null
              ? "Enter valid number not characters"
              : null,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            fillColor: Colors.black12,
            hintText: "100",
            labelText: 'Collected Amount',
            prefixIcon: Icon(Icons.money),
          ),
        ),
      ],
    );
  }
}
