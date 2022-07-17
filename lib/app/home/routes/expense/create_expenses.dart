import 'package:expense_tracker/app/home/routes/expense/create_categories.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/expense_categories/expense_categories_cubit.dart';
import 'package:expense_tracker/data/remote/expenses_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateExpense extends StatefulWidget {
  const CreateExpense({Key? key}) : super(key: key);

  @override
  _CreateExpenseState createState() => _CreateExpenseState();
}

class _CreateExpenseState extends State<CreateExpense> {
  late ExpenseCategoriesCubit _expenses;
  final TextEditingController _title = TextEditingController();
  final TextEditingController _desc = TextEditingController();
  final TextEditingController _amount = TextEditingController();
  final ExpensesClient _clt = ExpensesClient();

  bool _isAdding = false;

  void _addNewExpenseCategories(BuildContext context) async =>
      await showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: const CreateCategory(),
              ));
  void _addExpense(BuildContext context) async {
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
    if (_expenses.sources.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Add some caegories')));
      return;
    }
    setState(() {
      _isAdding = !_isAdding;
    });
    bool? _isOk = await _clt.createExpense(
        _title.text, double.parse(_amount.text),
        categories: [], desc: _desc.text);
    if (_isOk == true) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Add successfully')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('failed to add')));
    }
    setState(() {
      _isAdding = !_isAdding;
    });
  }

  @override
  void initState() {
    super.initState();
    _expenses = BlocProvider.of<ExpenseCategoriesCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Expenses'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(children: [
              const SizedBox(height: 80),
              TextField(
                controller: _title,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    helperText: 'Maximum of 50 lines allowed',
                    hintText: 'Title'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _desc,
                maxLines: 3,
                decoration: const InputDecoration(
                    helperText: 'max 250 words aloed', hintText: 'Description'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              ListTile(
                  trailing: IconButton(
                      onPressed: () => _expenses.refreshCategories(),
                      icon: const Icon(Icons.refresh)),
                  title: Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: const Text('Choose your categories')),
              SizedBox(
                height: _size.height * 0.23,
                child:
                    BlocBuilder<ExpenseCategoriesCubit, ExpenseCategoriesState>(
                        builder: (context, state) {
                  if (state is ExpenseCategoriesLoad) {
                    _expenses.getCategories();
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ExpenseCategoriesLoadSuccess) {
                    return ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.models.length,
                        itemBuilder: (BuildContext context, int item) {
                          return ExpenseCategoryListTile(
                            id: state.models[item]!.id,
                            title: state.models[item]!.title,
                            subtitle: state.models[item]!.desc ?? '',
                          );
                        });
                  }
                  if (state is ExpenseCategoriesLoadFailed) {
                    return const Icon(Icons.sms_failed);
                  } else {
                    return const SizedBox();
                  }
                }),
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      fixedSize: Size(_size.width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () => _addNewExpenseCategories(context),
                  child: Text('Add Categories',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white))),
              const Divider(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_size.width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () => _addExpense(context),
                  child: Text(_isAdding ? 'Adding...' : 'Add Expenses',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Colors.white)))
            ]),
          ),
        ));
  }
}