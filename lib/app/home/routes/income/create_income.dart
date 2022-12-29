import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

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
  late TextEditingController _amount;
  late TextEditingController _desc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _selectSources() => showModalBottomSheet(
        context: context,
        builder: (context) => const IncomeSourcePicker(),
      );

  void _addNewIncome() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<IncomeCubit>().addIncome(
          CreateIncomeModel(
            title: _title.text,
            amount: double.parse(_amount.text),
            desc: _desc.text,
            sources: context.read<IncomeCubit>().notifier.selected,
          ),
        );

    if (mounted) {
      Navigator.of(context).popUntil(ModalRoute.withName('/income'));
    }
  }

  void _updateIncome() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<IncomeCubit>().updateIncome(
          UpdateIncomeModel(
            id: widget.income!.id,
            title: _title.text,
            amount: double.parse(_amount.text),
            desc: _desc.text,
            sources: context.read<IncomeCubit>().notifier.selected,
          ),
        );

    if (mounted) {
      Navigator.of(context).popUntil(ModalRoute.withName('/income'));
    }
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(
        text: widget.isUpdate ? widget.income?.title : null);
    _desc = TextEditingController(
        text: widget.isUpdate ? widget.income?.desc : null);
    _amount = TextEditingController(
        text: widget.isUpdate ? widget.income?.amount.toString() : null);
    context.read<IncomeCubit>().notifier
      ..clear()
      ..addBulk(widget.isUpdate ? widget.income!.sources : []);
  }

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    _desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Update Income' : 'Add Income'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) => value != null && value.isEmpty
                    ? "Title cannot be empty"
                    : null,
                controller: _title,
                keyboardType: TextInputType.name,
                maxLength: 50,
                decoration: const InputDecoration(
                    labelText: 'Title',
                    helperText: 'Income title can be of maximum 50 characters'),
              ),
              const SizedBox(height: 15),
              TextField(
                maxLines: 3,
                controller: _desc,
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
                controller: _amount,
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
              const Expanded(
                child: IncomeSourceGrid(),
              )
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
              fixedSize: Size(size.width, 50),
            ),
            onPressed: widget.isUpdate ? _updateIncome : _addNewIncome,
            child: Text(widget.isUpdate ? 'Update Income' : 'Create Income'),
          ),
        ),
      ),
    );
  }
}
