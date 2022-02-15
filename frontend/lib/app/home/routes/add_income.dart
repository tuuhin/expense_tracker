import 'package:expense_tracker/app/home/routes/add_source.dart';
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
  final TextEditingController _dateTime = TextEditingController();

  void _showBottomSheet(BuildContext context) => showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      context: context,
      builder: (context) => const AddSource());

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    return Scaffold(
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
                end: Alignment.centerRight,
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
              const SizedBox(height: 80),
              TextField(
                readOnly: true,
                controller: _dateTime,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Income Ammount',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () async {
                          DateTime? _value = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.utc(2020),
                              lastDate: DateTime.utc(2023));

                          if (_value != null) {
                            _dateTime.text = _value.day.toString();
                          }
                        },
                        icon: const Icon(Icons.date_range)),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Income Title',
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _value,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Income Ammount',
                ),
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
                    // OutlinedButton(
                    //     onPressed: () {}, child: const Icon(Icons.add)),
                    IncomeChips(
                      label: 'fgnoinoignsiognsoigsdno',
                      onDelete: () => {},
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
                  onPressed: () {},
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
