import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';

import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';
import '../routes.dart';

class CreateIncome extends StatefulWidget {
  final IncomeModel? income;
  final bool isUpdate;
  const CreateIncome({super.key, this.income, this.isUpdate = false})
      : assert(isUpdate ? income != null : true);

  @override
  State<CreateIncome> createState() => _CreateIncomeState();
}

class _CreateIncomeState extends State<CreateIncome> {
  late TextEditingController _title;
  late TextEditingController _value;
  late TextEditingController _description;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _selectSources() => showModalBottomSheet(
        context: context,
        builder: (context) => IncomeSourcePicker(
          sources: context.read<IncomeCubit>().sources,
        ),
      );

  void _showBottomSheet() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateSource(),
        ),
      );

  void _addNewIncome() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<IncomeCubit>().addIncome(
          CreateIncomeModel(
            title: _title.text,
            amount: double.parse(_value.text),
            desc: _description.text,
            sourcesId: context
                .read<IncomeCubit>()
                .notifier
                .selected
                .map((e) => e.id)
                .toList(),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _value = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _title.dispose();
    _value.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Income'),
      ),
      body: BlocListener<UiEventCubit<IncomeModel>, UiEventState<IncomeModel>>(
        bloc: context.read<IncomeCubit>().uiEvent,
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Title cannot be empty"
                      : null,
                  controller: _title,
                  keyboardType: TextInputType.name,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      labelText: 'Title',
                      helperText:
                          'Income title can be of maximum 50 characters'),
                ),
                const SizedBox(height: 15),
                TextField(
                  maxLines: 3,
                  controller: _description,
                  maxLength: 250,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      labelText: 'Description',
                      helperText:
                          'Add a income description for future preference'),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  validator: (value) =>
                      value != null && double.tryParse(value) == null
                          ? "Non number value are not allowed"
                          : null,
                  controller: _value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                ListTile(
                  onTap: _selectSources,
                  trailing: const Icon(Icons.add),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 5),
                  title: const Text('Sources'),
                  subtitle: const Text('Select your income sources'),
                ),
                const SizedBox(height: 10),
                const Expanded(child: IncomeSourceGrid())
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
                onPressed: _showBottomSheet,
                child: const Text('Add new  Sources',
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              const Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  fixedSize: Size(size.width, 50),
                ),
                onPressed: _addNewIncome,
                child: const Text('Add Income'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
