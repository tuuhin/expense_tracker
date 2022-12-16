import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/home/routes/routes.dart';
import '../../../../app/widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../../main.dart';

class CreateExpense extends StatefulWidget {
  final ExpenseModel? expense;
  final bool isUpdate;
  const CreateExpense({
    super.key,
    this.expense,
    this.isUpdate = false,
  }) : assert(isUpdate ? expense != null : true);

  @override
  State<CreateExpense> createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;

  BudgetModel? _selectedBudget;
  File? receipt;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addExpense() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedBudget != null &&
        _selectedBudget!.amount - _selectedBudget!.amountUsed <
            double.parse(_amount.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("This amount is too much for this budget"),
        ),
      );
      return;
    }

    await context.read<ExpenseCubit>().addExpense(
          CreateExpenseModel(
            title: _title.text,
            amount: double.parse(_amount.text),
            budgetId: _selectedBudget!.id,
            categoryIds: context
                .read<ExpenseCubit>()
                .notifier
                .selected
                .map((e) => e.id)
                .toList(),
            desc: _desc.text.isEmpty ? null : _desc.text,
            path: receipt?.path,
          ),
        );
    logger.fine('DOne');
  }

  void _addExpenseCategories() => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateCategory()));

  void _addCategoriesTag() => showModalBottomSheet(
      context: context, builder: (context) => const ExpenseCategoryPicker());

  void _imagePicker() => showModalBottomSheet(
        context: context,
        builder: (context) =>
            ReceiptPicker(setFile: (file) => setState(() => receipt = file)),
      );

  @override
  void initState() {
    super.initState();

    _title = TextEditingController();
    _desc = TextEditingController();
    _amount = TextEditingController();

    if (widget.isUpdate == true && widget.expense != null) {
      _title.text = widget.expense!.title;
      _desc.text = widget.expense?.desc ?? '';
      _amount.text = widget.expense?.amount.toString() ?? '0';
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  Widget _pickImage() => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: _imagePicker,
        child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.grey)),
          child: receipt != null
              ? Image.file(receipt!,
                  alignment: Alignment.center, semanticLabel: 'receipt')
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
                ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdate ? 'Update Expense ' : 'Add Expenses')),
      resizeToAvoidBottomInset: false,
      body:
          BlocListener<UiEventCubit<ExpenseModel>, UiEventState<ExpenseModel>>(
        bloc: context.read<ExpenseCubit>().uiEvent,
        listener: (context, state) => state.whenOrNull(
          showSnackBar: (message, data) => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            ),
          showDialog: (message, content, data) => showDialog(
              context: context,
              builder: (context) =>
                  UiEventDialog(title: message, content: content)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Divider(),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Cannot have a empty title"
                      : null,
                  controller: _title,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    helperText: 'Maximum 50 characters ',
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _desc,
                  maxLines: 3,
                  maxLength: 250,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  decoration: const InputDecoration(
                    helperText: 'Maximum 250 characters',
                    hintText: 'Description',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _pickImage(),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          StatefulBuilder(
                            builder: (context, changeState) =>
                                DropdownButtonFormField(
                              validator: (value) => value == null
                                  ? "A bugdet need to added"
                                  : null,
                              value: _selectedBudget,
                              isExpanded: true,
                              hint: const Text('Pick a Budget'),
                              borderRadius: BorderRadius.circular(10),
                              alignment: Alignment.center,
                              decoration:
                                  const InputDecoration(helperText: "Budget"),
                              items: context
                                  .read<BudgetCubit>()
                                  .cachedBudget()
                                  .map<DropdownMenuItem<BudgetModel>>(
                                    (BudgetModel budget) => DropdownMenuItem(
                                      value: budget,
                                      child: Text(
                                        budget.title.toUpperCase(),
                                        style: _selectedBudget == budget
                                            ? Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                            : Theme.of(context)
                                                .textTheme
                                                .caption
                                                ?.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (BudgetModel? budget) {
                                // isBudgetPicked = true;
                                logger.fine(budget);
                                changeState(() => _selectedBudget = budget);
                              },
                            ),
                          ),
                          const SizedBox(height: 4),
                          TextFormField(
                            validator: (value) =>
                                value != null && double.tryParse(value) == null
                                    ? "Cannot have a non numeric value"
                                    : null,
                            controller: _amount,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: 'Amount',
                              helperText: 'Amount cannot be zero',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListTile(
                    onTap: _addCategoriesTag,
                    trailing: const Icon(Icons.add),
                    title: const Text('Pick your categories')),
                const Expanded(child: ExpenseCategoryGrid())
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                  style:
                      OutlinedButton.styleFrom(fixedSize: Size(size.width, 50)),
                  onPressed: _addExpenseCategories,
                  child: const Text('Add Categories',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(size.width, 50)),
                  onPressed: _addExpense,
                  child: const Text('Add Expenses'))
            ],
          ),
        ),
      ),
    );
  }
}
