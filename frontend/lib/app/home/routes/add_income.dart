import 'package:expense_tracker/app/home/routes/add_source.dart';
import 'package:expense_tracker/app/home/routes/get_sources.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddIncome extends StatefulWidget {
  const AddIncome({Key? key}) : super(key: key);

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _value = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final OutlinedBorder _bottomSheetBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  void _showBottomSheet(BuildContext context) => showModalBottomSheet(
      shape: _bottomSheetBorder,
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: const AddSource(),
          ));

  void _getSources(BuildContext context) => showModalBottomSheet(
      shape: _bottomSheetBorder,
      context: context,
      builder: (context) => const GetIncomeSources());

  void _addNewIncome(BuildContext context) async {
    if (_title.text.isEmpty || _value.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Either one of title or amount is blank')));
      return;
    }
    if (num.tryParse(_value.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Amount is not a number ')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Add Income'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              Theme.of(context).scaffoldBackgroundColor,
            ])),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 70),
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
                    helperText:
                        'Add a income description for future preference'),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
              ),
              const ListTile(
                title: Text('Sources'),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 2,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onPressed: () => _getSources(context),
                        child: const Icon(Icons.add)),
                    IncomeChips(
                      label: 'food',
                      onDelete: () => {},
                    ),
                    Chip(
                      label: Text('hellow'),
                      onDeleted: () {},
                    ),
                    IncomeChips(
                      label: 'hellow',
                      onDelete: () {},
                    ),
                    Chip(
                      label: Text('hellow'),
                      onDeleted: () {},
                    ),
                    Chip(
                      label: Text('hellow'),
                      onDeleted: () {},
                    ),
                    Chip(
                      label: Text('hellow'),
                      onDeleted: () {},
                    ),
                    Chip(
                      label: Text('hellow'),
                      onDeleted: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () => _showBottomSheet(context),
                  child: Text('Add new  Sources',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () => _addNewIncome(context),
                  child: Text('Add Income',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
