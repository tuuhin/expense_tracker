import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/income/income_models.dart';
import '../../../../utils/resource.dart';
import '../../../widgets/income/income_source_grid.dart';
import '../routes.dart';
import 'income_source_picker.dart';

class CreateIncome extends StatefulWidget {
  const CreateIncome({Key? key}) : super(key: key);

  @override
  State<CreateIncome> createState() => _CreateIncomeState();
}

class _CreateIncomeState extends State<CreateIncome> {
  late TextEditingController _title;
  late TextEditingController _value;
  late TextEditingController _description;

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

    Resource<IncomeModel> resource = await context
        .read<IncomeCubit>()
        .addIncome(_title.text, double.parse(_value.text),
            desc: _description.text,
            sources: context.read<IncomeCubit>().notifier.sources);

    resource.when(
        loading: () {},
        data: (data, message) {
          if (mounted) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(content: Text("Income created ")));
        },
        error: (err, errorMessage, data) {
          if (mounted) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text(errorMessage)));
        });
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
                  style:
                      OutlinedButton.styleFrom(fixedSize: Size(size.width, 50)),
                  onPressed: _showBottomSheet,
                  child: const Text('Add new  Sources',
                      style: TextStyle(fontWeight: FontWeight.w600))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
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
