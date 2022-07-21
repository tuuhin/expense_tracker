import 'package:expense_tracker/app/home/routes/route_builder.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeSourcePicker extends StatefulWidget {
  const IncomeSourcePicker({Key? key}) : super(key: key);

  @override
  State<IncomeSourcePicker> createState() => _IncomeSourcePickerState();
}

class _IncomeSourcePickerState extends State<IncomeSourcePicker> {
  late IncomeSourceCubit _incomeSourceCubit;

  @override
  void initState() {
    super.initState();
    _incomeSourceCubit = BlocProvider.of<IncomeSourceCubit>(context);
    _incomeSourceCubit.getIncomeSources();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<IncomeSourceCubit, IncomeSourceState>(
        builder: (context, state) {
          if (state is IncomeStateSuccess) {
            return Column(
              children: [
                Text('Pick Sources',
                    style: Theme.of(context).textTheme.headline6),
                const Divider(),
                Expanded(
                  child: AnimatedList(
                    key: _incomeSourceCubit.incomeListKey,
                    itemBuilder: (context, index, animation) => FadeTransition(
                      opacity: animation.drive<double>(opacity),
                      child: IncomeSourcePickerTile(
                        source: state.data![index],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (state is ExpenseCategoryStateFailed) {
            return Container(height: 200, color: Colors.red);
          }
          return Column(
            children: [
              const Divider(height: 1),
              const Spacer(),
              const CircularProgressIndicator(),
              const SizedBox(height: 15),
              Text('Fetching results',
                  style: Theme.of(context).textTheme.caption),
              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}
