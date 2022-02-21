import 'package:expense_tracker/services/api/expenses_client.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  const AddCategories({Key? key}) : super(key: key);

  @override
  State<AddCategories> createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {
  final ExpensesClient _client = ExpensesClient();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final ShapeBorder _shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)));
  bool _isLoading = false;

  void _addCategory(BuildContext context) async {
    if (_title.text.isEmpty) {
      return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape: _shapeBorder,
                content: const Text('Blank title is not allowed'),
              ));
    }
    if (!_isLoading) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
    bool? isOk =
        await _client.addExpenseCategory(_title.text, desc: _desc.text);
    if (isOk == true) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Added successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return SizedBox(
      height: _size.height * .45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    fixedSize: Size(_size.width, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                onPressed: () => _addCategory(context),
                child: Text(_isLoading ? 'Adding...' : 'Add category',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
