import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:flutter/material.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;

  void _addExpenseCategories() => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateCategory(),
        ),
      );
  void _addExpense() async {
    if (_title.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expense entry must have a title')));
      return;
    }
    if (_amount.text.isEmpty || num.tryParse(_amount.text) == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Amount is invalid')));
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _desc = TextEditingController();
    _amount = TextEditingController();
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
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expenses'),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          const Divider(),
          TextField(
            controller: _title,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              helperText: 'Maximum of 50 lines allowed',
              hintText: 'Title',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _desc,
            maxLines: 3,
            decoration: const InputDecoration(
              helperText: 'max 250 words allowed',
              hintText: 'Description',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amount,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: 'Amount'),
          ),
          const SizedBox(height: 10),
          DropdownButton(
            hint: const Text('Budget'),
            menuMaxHeight: _size.height * .2,
            items: List.generate(10, (index) => '$index')
                .map<DropdownMenuItem<String>>(
                  (String item) => DropdownMenuItem(
                    value: item,
                    child: SizedBox(width: _size.width * .8, child: Text(item)),
                  ),
                )
                .toList(),
            onChanged: (s) {},
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () => {},
            trailing: const Icon(Icons.refresh),
            title: Text('Choose your categories',
                style: Theme.of(context).textTheme.caption),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(_size.width, 50),
                ),
                onPressed: _addExpenseCategories,
                child: const Text(
                  'Add Categories',
                  style: TextStyle(fontWeight: FontWeight.w600),
                )),
            const Divider(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary,
                  fixedSize: Size(_size.width, 50),
                ),
                onPressed: _addExpense,
                child: const Text('Add Expenses'))
          ],
        ),
      )),
    );
  }
}
