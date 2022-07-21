import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/income/income_source_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeSourcePickerTile extends StatefulWidget {
  final IncomeSourceModel source;
  const IncomeSourcePickerTile({Key? key, required this.source})
      : super(key: key);

  @override
  State<IncomeSourcePickerTile> createState() => _IncomeSourcePickerTileState();
}

class _IncomeSourcePickerTileState extends State<IncomeSourcePickerTile> {
  late IncomeCubit _incomeCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _incomeCubit = BlocProvider.of<IncomeCubit>(context);
  }

  void onCheck(bool? check) =>
      setState(() => _incomeCubit.notifier.checkSource(widget.source));

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: CheckboxListTile(
        value: _incomeCubit.notifier.sourceInList(widget.source),
        onChanged: onCheck,
        title: Text(
          '${widget.source.title} ${widget.source.isSecure == true ? '✅' : ''}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: widget.source.desc != null
            ? Text(
                widget.source.desc!,
                style: const TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w400),
              )
            : null,
      ),
    );
  }
}
