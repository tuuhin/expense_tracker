import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/resource.dart';

class IncomeSourceCard extends StatefulWidget {
  final IncomeSourceModel? source;
  const IncomeSourceCard({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  State<IncomeSourceCard> createState() => _IncomeSourceCardState();
}

class _IncomeSourceCardState extends State<IncomeSourceCard> {
  Future<void> _deleteSource() async {
    Resource request = await context
        .read<IncomeSourceCubit>()
        .deleteIncomeSource(widget.source!);

    if (mounted && request.message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(request.message!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primary,
      child: ListTile(
        trailing: IconButton(
            onPressed: _deleteSource, icon: const Icon(Icons.delete_outline)),
        title: Text(
          widget.source!.title,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: widget.source!.desc != null
            ? Text(
                widget.source!.desc!,
                style: const TextStyle(
                    color: Colors.white60, fontWeight: FontWeight.w400),
                overflow: TextOverflow.ellipsis,
              )
            : null,
      ),
    );
  }
}
