import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class CreateSource extends StatefulWidget {
  const CreateSource({Key? key}) : super(key: key);

  @override
  State<CreateSource> createState() => _CreateSourceState();
}

class _CreateSourceState extends State<CreateSource> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  late TextEditingController _title;
  late TextEditingController _desc;

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
    if (!_fromKey.currentState!.validate()) return;

    context
        .read<IncomeSourceCubit>()
        .addSource(CreateIncomeSourceModel(
            title: _title.text,
            isSecure: _isSecure,
            desc: _desc.text.isEmpty ? null : _desc.text))
        .then(Navigator.of(context).pop);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _fromKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              validator: (value) => value != null && value.length < 5
                  ? "The size is too small"
                  : null,
              controller: _title,
              decoration: const InputDecoration(
                  hintText: 'Title',
                  helperText: 'Maximum 50 characters alowed'),
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              controller: _desc,
              decoration: const InputDecoration(
                  hintText: 'Description',
                  helperText: 'Maximum 250 characters alowed'),
            ),
            CheckboxListTile(
              checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              dense: true,
              value: _isSecure,
              onChanged: (t) => setState(() => _isSecure = t ?? false),
              title: const Text("An healthy source"),
              subtitle: const Text("Is this an verified source,"),
            ),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(size.width, 50)),
                onPressed: _addSource,
                child: const Text('Add Income Source'))
          ],
        ),
      ),
    );
  }
}
