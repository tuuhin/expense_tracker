import 'dart:math';

import 'package:expense_tracker/app/home/routes/income/income_source_picker.dart';
import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/income/income_source_grid.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';

class CreateIncome extends StatefulWidget {
  const CreateIncome({Key? key}) : super(key: key);

  @override
  State<CreateIncome> createState() => _CreateIncomeState();
}

class _CreateIncomeState extends State<CreateIncome> {
  late TextEditingController _title;
  late TextEditingController _value;
  late TextEditingController _description;
  late IncomeCubit _incomeCubit;

  void _selectSources() => showModalBottomSheet(
      context: context, builder: (context) => const IncomeSourcePicker());

  void _showBottomSheet() => showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const CreateSource(),
          ));

  void _addNewIncome() async {
    if (_title.text.isEmpty || _value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some required fields are blank')),
      );
      return;
    }
    if (num.tryParse(_value.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount should alaways be a number.')),
      );
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Adding Income')));

    Resource resource = await _incomeCubit.addIncome(
        _title.text, double.parse(_value.text),
        desc: _description.text, sources: _incomeCubit.notifier.sources);

    if (resource is ResourceSucess) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Income created')));
    }
    if (resource is ResourceFailed) {
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
            const SnackBar(content: Text('Income Failed to be created ')));
    }
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _value = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _incomeCubit = BlocProvider.of<IncomeCubit>(context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Divider(),
            TextField(
              controller: _title,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                  labelText: 'Title',
                  helperText: 'Income title can be of maximum 50 characters'),
            ),
            const SizedBox(height: 15),
            TextField(
              maxLines: 3,
              controller: _description,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  helperText: 'Add a income description for future preference'),
            ),
            const SizedBox(height: 15),
            TextField(
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(size.width, 50)),
                  onPressed: _showBottomSheet,
                  child: const Text('Add new  Sources',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(size.width, 50),
                  ),
                  onPressed: _addNewIncome,
                  child: const Text('Add Income'))
            ],
          ),
        ),
      ),
    );
  }
}
