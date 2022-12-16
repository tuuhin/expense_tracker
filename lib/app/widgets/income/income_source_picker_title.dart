import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class IncomeSourcePickerTile extends StatefulWidget {
  final IncomeSourceModel source;
  const IncomeSourcePickerTile({super.key, required this.source});

  @override
  State<IncomeSourcePickerTile> createState() => _IncomeSourcePickerTileState();
}

class _IncomeSourcePickerTileState extends State<IncomeSourcePickerTile> {
  late Notifier<IncomeSourceModel> _notifier;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _notifier = BlocProvider.of<IncomeCubit>(context).notifier;
  }

  void _onCheck(bool? check) => setState(() => _notifier.check(widget.source));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        child: CheckboxListTile(
          value: _notifier.isThere(widget.source),
          onChanged: _onCheck,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.source.title),
              if (widget.source.isSecure == true) ...[
                const SizedBox(width: 10),
                Image.asset("assets/icons/checked.png")
              ]
            ],
          ),
          subtitle: widget.source.desc != null
              ? Text(
                  widget.source.desc!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      overflow: TextOverflow.ellipsis),
                )
              : null,
        ),
      ),
    );
  }
}
