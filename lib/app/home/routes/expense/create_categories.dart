import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  late TextEditingController _title;
  late TextEditingController _desc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  void _addCategory() async {
    if (!_formKey.currentState!.validate()) return;

    context
        .read<ExpenseCategoriesCubit>()
        .createCategory(CreateCategoryModel(
          title: _title.text.trim(),
          desc: _desc.text.isEmpty ? null : _desc.text,
        ))
        .then(Navigator.of(context).pop);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            TextFormField(
              controller: _title,
              validator: (value) => value != null && value.isEmpty
                  ? 'Can\'t have a blank title'
                  : value != null && value.length > 50
                      ? 'Title cannot have more than 50 chars'
                      : null,
              decoration: const InputDecoration(
                hintText: 'Title',
                helperText: 'Category Title',
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              controller: _desc,
              validator: (value) => value != null && value.length > 250
                  ? 'Description is too big'
                  : null,
              decoration: const InputDecoration(
                hintText: 'Description',
                helperText: 'Category Description',
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(size.width, 50)),
                onPressed: _addCategory,
                child: const Text('Create category'))
          ],
        ),
      ),
    );
  }
}
