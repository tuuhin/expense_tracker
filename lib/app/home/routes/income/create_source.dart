import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/income/income_source_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../utils/resource.dart';

class CreateSource extends StatefulWidget {
  const CreateSource({Key? key}) : super(key: key);

  @override
  State<CreateSource> createState() => _CreateSourceState();
}

class _CreateSourceState extends State<CreateSource> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late IncomeSourceCubit _incomeSourceCubit;
  bool _isSecure = true;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _desc = TextEditingController();
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  void _addSource() async {
    if (_title.text.isEmpty) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Source can\'t have a blank title')));
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Adding source ${_title.text}')));

    Resource<IncomeSourceModel?> resource = await _incomeSourceCubit
        .addIncomeSource(_title.text, desc: _desc.text, isSecure: _isSecure);
    if (mounted) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    if (resource is ResourceSucess) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Succuessfully created category ${resource.data!.title}',
          ),
        ),
      );
    }
    if (resource is ResourceFailed) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(resource.message.toString()),
        ),
      );
    }
    if (mounted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.of(context)
        ..pop()
        ..pop();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _incomeSourceCubit = BlocProvider.of<IncomeSourceCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: _title,
            decoration: const InputDecoration(
                hintText: 'Title', helperText: 'Maximum 50 characters alowed'),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            controller: _desc,
            decoration: const InputDecoration(
                hintText: 'Description',
                helperText: 'Maximum 250 characters alowed'),
          ),
          Row(
            children: [
              Checkbox(
                  value: _isSecure,
                  onChanged: (bool? value) =>
                      setState(() => _isSecure = value ?? false)),
              const Text('Weather this is a healthy source')
            ],
          ),
          const Divider(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(size.width, 50),
              ),
              onPressed: _addSource,
              child: const Text('Add Income Source'))
        ],
      ),
    );
  }
}
