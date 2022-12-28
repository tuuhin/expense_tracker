import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';
import '../../../widgets/widgets.dart';

class CreateBudget extends StatefulWidget {
  final BudgetModel? budget;
  final bool isUpdate;
  const CreateBudget({
    super.key,
    this.budget,
    this.isUpdate = false,
  }) : assert(isUpdate ? budget != null : true);

  @override
  State<CreateBudget> createState() => _CreateBudgetState();
}

class _CreateBudgetState extends State<CreateBudget> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _amount;
  late DateTime _from;
  late DateTime _to;

  final GlobalKey<FormState> _forms = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _title = TextEditingController(
      text: widget.isUpdate ? widget.budget?.title : null,
    );
    _desc = TextEditingController(
      text: widget.isUpdate ? widget.budget?.desc : null,
    );
    _amount = TextEditingController(
      text: widget.isUpdate ? widget.budget?.amount.toString() : null,
    );
    _from = widget.isUpdate ? widget.budget!.start : DateTime.now();
    _to = widget.isUpdate
        ? widget.budget!.end
        : DateTime.now().add(const Duration(days: 10));
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

    context.read<BudgetCubit>().updateBudget(widget.budget!.copyWith(
          title: _title.text,
          desc: _desc.text.isEmpty ? null : _desc.text,
          start: _from,
          end: _to,
          amount: double.parse(_amount.text),
        ));
    Navigator.of(context).popUntil(ModalRoute.withName('/budgets'));
  }

  void _createBudget() {
    if (!_forms.currentState!.validate()) return;

    context.read<BudgetCubit>().addBudget(CreateBudgetModel(
          title: _title.text,
          desc: _desc.text.isEmpty ? null : _desc.text,
          start: _from,
          end: _to,
          amount: double.parse(_amount.text),
        ));

    Navigator.of(context).popUntil(ModalRoute.withName('/budgets'));
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
          title: Text(widget.isUpdate ? 'Update Budget' : 'Create Budget')),
      body: BlocListener<UiEventCubit<BudgetModel>, UiEventState<BudgetModel>>(
        bloc: context.read<BudgetCubit>().uievent,
        listener: (context, state) => state.whenOrNull(
          showSnackBar: (message, data) => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(message))),
          showDialog: (message, content, data) => showDialog(
            context: context,
            builder: (context) =>
                UiEventDialog(title: message, content: content),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _forms,
            child: CreateBudgetForm(
              title: _title,
              desc: _desc,
              amount: _amount,
              fromDate: _from,
              toDate: _to,
              pickFromDate: _pickFromDate,
              pickToDate: _pickToDate,
            ),
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
