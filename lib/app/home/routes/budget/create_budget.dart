import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../../utils/date_formaters.dart';

class CreateBudget extends StatefulWidget {
  final BudgetModel? budget;
  final bool isUpdate;
  const CreateBudget({super.key, this.budget, this.isUpdate = false})
      : assert(isUpdate ? budget != null : true);

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;
  late DateTime _from;
  late DateTime _to;

  bool _isPopAllowed = true;
  final GlobalKey<FormState> _forms = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _title = TextEditingController();
    _desc = TextEditingController();
    _amount = TextEditingController();
    _from = DateTime.now();
    _to = DateTime.now().add(const Duration(days: 10));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.isUpdate && widget.budget != null) {
      _title.text = widget.budget!.title;
      _desc.text = widget.budget?.desc ?? '';
      _amount.text = widget.budget!.amount.toString();
      _from = widget.budget!.start;
      _to = widget.budget!.end;
    }
  }

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _updateBudget() {
    if (!_forms.currentState!.validate()) return;

    context.read<BudgetCubit>().updateBudget(
          widget.budget!.copyWith(
            title: _title.text,
            desc: _desc.text.isEmpty ? null : _desc.text,
            start: _from,
            end: _to,
            amount: double.parse(_amount.text),
          ),
        );
  }

  void _createBudget() async {
    if (_forms.currentState!.validate()) {
      _isPopAllowed = false;

      context.read<BudgetCubit>().addBudget(
            CreateBudgetModel(
              title: _title.text,
              desc: _desc.text.isEmpty ? null : _desc.text,
              start: _from,
              end: _to,
              amount: double.parse(_amount.text),
            ),
          );

      _isPopAllowed = true;
    }
  }

  Future<bool> _allowPop() async {
    if (!_isPopAllowed) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: const Text('Creating your budget please wait '),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop, child: const Text('OK'))
          ],
        ),
      );
    }
    return _isPopAllowed;
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
      firstDate: DateTime.now().subtract(const Duration(days: 200)),
      lastDate: DateTime.now().add(const Duration(days: 200)),
    );
    if (toDateTime == null) return;
    if (toDateTime.compareTo(DateTime.now().add(const Duration(days: 5))) ==
        -1) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'A budget acts as a long term promise , a lifespan of a less than 5 days  is very low.'),
          ),
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
        title: widget.isUpdate
            ? const Text('Update Budget')
            : const Text('Create Budget'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          onWillPop: _allowPop,
          key: _forms,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) => value != null && value.isEmpty
                    ? 'Untitled budget cannot be created '
                    : value != null && value.length < 5
                        ? 'Minimum 5 chars are reqired'
                        : null,
                controller: _title,
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    helperText: 'Maximum of 50 lines allowed',
                    hintText: 'Title'),
              ),
              const SizedBox(height: 4),
              TextFormField(
                controller: _desc,
                maxLength: 250,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    helperText: 'Maximum 250 words allowed',
                    hintText: 'Description'),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      trailing: const Text("FROM",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      onTap: _pickFromDate,
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:
                            const Icon(Icons.date_range, color: Colors.white),
                      ),
                      title: Text(toSimpleDate(_from)),
                    ),
                    const Divider(height: 4),
                    ListTile(
                      onTap: _pickToDate,
                      trailing: const Text("TO",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      leading: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:
                            const Icon(Icons.date_range, color: Colors.white),
                      ),
                      title: Text(toSimpleDate(_to)),
                    ),
                  ],
                ),
              ),
              TextFormField(
                validator: (value) => value != null && value.isEmpty
                    ? 'Amount should be greater than 0.0'
                    : value != null && double.tryParse(value) == null
                        ? 'Please provide a amount not a bunch of characters'
                        : null,
                controller: _amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Amount'),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            onPressed: widget.isUpdate ? _updateBudget : _createBudget,
            child: widget.isUpdate
                ? const Text('Update Budget')
                : const Text('Create Budget'),
          ),
        ),
      ),
    );
  }
}
