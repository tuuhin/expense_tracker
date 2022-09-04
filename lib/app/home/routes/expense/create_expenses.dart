import 'dart:io';
import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/expense/receipt_picker.dart';
import 'package:expense_tracker/context/budget/budget_cubit.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;
  late BudgetCubit _budgetCubit;

  BudgetModel? _selectedBudget;
  File? receipt;

  bool isBudgetPicked = false;

  void _addExpenseCategories() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateCategory(),
        ),
      );
  void _addExpense() async {
    if (_title.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expense entry must have a title')));
      return;
    }
    if (_amount.text.isEmpty || num.tryParse(_amount.text) == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Amount is invalid')));
      return;
    }
  }

  void _addCategoriesTag() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(),
    );
  }

  void _imagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ReceiptPicker(setFile: (file) => setState(() => receipt = file)),
    );
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _desc = TextEditingController();
    _amount = TextEditingController();
    _budgetCubit = BlocProvider.of<BudgetCubit>(context);
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  Widget pickImage() => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: _imagePicker,
        child: Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: receipt != null
                ? InteractiveViewer(
                    child: Image.file(
                      receipt!,
                      alignment: Alignment.center,
                      semanticLabel: 'receipt',
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.photo_outlined,
                          size: 40,
                          color: Theme.of(context).textTheme.caption?.color),
                      const SizedBox(height: 5),
                      Text('Add a recipt',
                          style: Theme.of(context).textTheme.caption)
                    ],
                  )),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expenses'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          const Divider(),
          TextField(
            controller: _title,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              helperText: 'Maximum of 50 lines allowed',
              hintText: 'Title',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _desc,
            maxLines: 3,
            decoration: const InputDecoration(
              helperText: 'max 250 words allowed',
              hintText: 'Description',
            ),
          ),
          const ListTile(
            dense: true,
            title: Text('Receipt and Amount Infomation'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              pickImage(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _amount,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(hintText: 'Amount'),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        value: _selectedBudget,
                        isExpanded: true,
                        hint: const Text('Pick a Budget'),
                        items: _budgetCubit.budgets
                            .map<DropdownMenuItem<BudgetModel>>(
                              (BudgetModel budget) => DropdownMenuItem(
                                enabled: _selectedBudget == budget,
                                value: budget,
                                child: Text(
                                  budget.title,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (BudgetModel? model) {
                          // isBudgetPicked = true;
                          logger.fine(model);
                          setState(() => _selectedBudget = model);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: _addCategoriesTag,
            dense: true,
            trailing: const Icon(Icons.add),
            title: const Text('Pick your categories'),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(size.width, 50),
                ),
                onPressed: _addExpenseCategories,
                child: const Text(
                  'Add Categories',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  fixedSize: Size(size.width, 50),
                ),
                onPressed: _addExpense,
                child: const Text('Add Expenses'))
          ],
        ),
      )),
    );
  }
}
