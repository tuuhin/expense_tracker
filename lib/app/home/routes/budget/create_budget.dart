import 'package:expense_tracker/context/budget/budget_cubit.dart';
import 'package:expense_tracker/utils/date_formaters.dart';
import 'package:expense_tracker/utils/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBudget extends StatefulWidget {
  const CreateBudget({Key? key}) : super(key: key);

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  late BudgetCubit _budgetCubit;
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;
  late DateTime _from;
  late DateTime _to;

  final String budget =
      'A budget helps create financial stability. By tracking expenses and following a plan,a budget puts a person on stronger financial footing for both the day-to-day and the long term.';

  final String budgetWarning =
      'A budget cant have a single day minimum lifetime of a budget is 10 days';

  @override
  void initState() {
    super.initState();
    _budgetCubit = BlocProvider.of<BudgetCubit>(context);
    _title = TextEditingController();
    _desc = TextEditingController();
    _amount = TextEditingController();
    _from = DateTime.now();
    _to = DateTime.now().add(const Duration(days: 10));
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _createBudget() async {
    if (_title.text.isEmpty || _amount.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some fields are empty')),
      );
      return;
    }
    if (double.tryParse(_amount.text) == null || _amount.text == '0') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Can\'t create a budget with this amount')),
      );
      return;
    }
    Resource newBudget = await _budgetCubit.createBudget(
        _title.text, double.parse(_amount.text),
        from: _from, to: _to, desc: _desc.text.isEmpty ? null : _desc.text);
    if (newBudget is ResourceSucess && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("New Budget Created ${_title.text}")));
      Navigator.of(context).pop();
    }
  }

  void _pickFromDate() async {
    DateTime? fromDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 100)));
    if (fromDateTime == null) return;
    setState(() => _from = fromDateTime);
  }

  void _pickToDate() async {
    DateTime? toDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 10)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 100)));
    if (toDateTime == null) return;
    if (toDateTime.day == DateTime.now().day) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(budgetWarning)),
        );
      }
      return;
    }
    setState(() => _to = toDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Budget'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
          child: Divider(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextField(
              controller: _title,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                helperText: 'Maximum of 50 lines allowed',
                hintText: 'Title',
              ),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _desc,
              maxLines: 3,
              decoration: const InputDecoration(
                helperText: 'Maximum 250 words allowed',
                hintText: 'Description',
              ),
            ),
            ListTile(
              onTap: _pickToDate,
              trailing: const Icon(Icons.date_range),
              leading: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('To', style: TextStyle(color: Colors.white)),
                ),
              ),
              title: Text(toSimpleDate(_to)),
            ),
            ListTile(
              trailing: Icon(Icons.date_range),
              onTap: _pickFromDate,
              leading: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('From', style: TextStyle(color: Colors.white)),
                ),
              ),
              title: Text(toSimpleDate(_from)),
            ),
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(budget, style: Theme.of(context).textTheme.caption),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                primary: Theme.of(context).colorScheme.secondary),
            onPressed: _createBudget,
            child: const Text('Add Budget'),
          ),
        ),
      ),
    );
  }
}
