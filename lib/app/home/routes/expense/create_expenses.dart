import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../context/context.dart';
import '../../../../app/widgets/widgets.dart';
import '../../../../domain/models/models.dart';

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

  BaseBudgetModel? _selectedBudget;
  File? _receipt;
  String? _imageUrl;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _addExpense() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<ExpenseCubit>().addExpense(
          CreateExpenseModel(
            title: _title.text,
            amount: double.parse(_amount.text),
            budgetId: _selectedBudget!.id,
            categories: context.read<ExpenseCubit>().notifier.selected,
            desc: _desc.text.isEmpty ? null : _desc.text,
            path: _receipt?.path,
          ),
        );
    if (mounted) {
      Navigator.of(context).popUntil(ModalRoute.withName('/expenes'));
    }
  }

  void _updateExpense() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<ExpenseCubit>().updateExpense(
          UpdateExpenseModel(
            id: widget.expense!.id,
            title: _title.text,
            amount: double.parse(_amount.text),
            budget: _selectedBudget!,
            categories: context.read<ExpenseCubit>().notifier.selected,
            desc: _desc.text.isEmpty ? null : _desc.text,
            path: _receipt?.path,
          ),
        );

    if (mounted) {
      Navigator.of(context).popUntil(ModalRoute.withName('/expenes'));
    }
  }

  void _pickImage(ImageSource source) async {
    try {
      XFile? file =
          await ImagePicker().pickImage(source: source, imageQuality: 50);
      if (file == null) return;
      setState(() => _receipt = File(file.path));
    } on PlatformException {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
            const SnackBar(content: Text("Platform exception occured")));
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
    }
  }

  void _clearImage() =>
      setState(() => _imageUrl != null ? _imageUrl = null : _receipt = null);

  void _addCategoriesTag() => showModalBottomSheet(
        context: context,
        builder: (context) => const ExpenseCategoryPicker(),
      );

  void _imagePickerSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => ImagePickerModal(
          camera: () => _pickImage(ImageSource.camera),
          gallery: () => _pickImage(ImageSource.gallery),
          clear: _clearImage,
        ),
      );

  @override
  void initState() {
    super.initState();

    _title = TextEditingController(
      text: widget.isUpdate ? widget.expense?.title : null,
    );
    _desc = TextEditingController(
      text: widget.isUpdate ? widget.expense?.desc : null,
    );
    _amount = TextEditingController(
      text: widget.isUpdate ? widget.expense?.amount.toString() : null,
    );

    _selectedBudget =
        widget.isUpdate ? widget.expense?.budget.toBaseModel() : null;
    _imageUrl = widget.isUpdate ? widget.expense?.imageURL : null;

    context.read<ExpenseCubit>().notifier
      ..clear()
      ..addBulk(widget.isUpdate ? widget.expense!.categories : []);
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.isUpdate ? 'Update Expense ' : 'Add Expenses')),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CreateExpenseForm(title: _title, desc: _desc),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.square(
                    dimension: size.width * .4,
                    child: GestureDetector(
                      onTap: _imagePickerSheet,
                      child: ExpenseImagePicker(
                          imageURL: _imageUrl, file: _receipt),
                    ),
                  ),
                  const VerticalDivider(width: 4),
                  Expanded(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        StatefulBuilder(
                          builder: (context, changeState) =>
                              ExpenseBudgetPicker(
                            selectedBudget: _selectedBudget,
                            onChange: (budget) =>
                                changeState(() => _selectedBudget = budget),
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
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: _addCategoriesTag,
                title: const Text('Pick your categories'),
                subtitle: const Text('Add the assocaited categories'),
              ),
              const Expanded(child: ExpenseCategoryGrid())
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(size.width, 50)),
            onPressed: widget.isUpdate ? _updateExpense : _addExpense,
            child: Text(widget.isUpdate ? 'Update Expense' : 'Create Expenses'),
          ),
        ),
      ),
    );
  }
}
