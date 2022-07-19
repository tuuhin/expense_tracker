import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/models/models.dart';
import '../../../../utils/resource.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({Key? key}) : super(key: key);

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late ExpenseCategoriesCubit _expenseCategoriesCubit;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _expenseCategoriesCubit = BlocProvider.of<ExpenseCategoriesCubit>(context);
  }

  void _addCategory() async {
    if (_title.text.isEmpty) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category Title can\'t be blank')));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Adding categoty ${_title.text}')));

    Resource<ExpenseCategoriesModel?> resource = await _expenseCategoriesCubit
        .addExpenseCategory(_title.text, desc: _desc.text);
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
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          TextField(
            controller: _title,
            decoration: const InputDecoration(
              hintText: 'Title',
              helperText: 'Maximum 50 characters alowed',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            maxLines: 3,
            controller: _desc,
            decoration: const InputDecoration(
              hintText: 'Description',
              helperText: 'Maximum 250 characters alowed',
            ),
          ),
          const Divider(),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(size.width, 50),
              ),
              onPressed: _addCategory,
              child: const Text('Add category'))
        ],
      ),
    );
  }
}
