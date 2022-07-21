import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/income/income_source_card.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowIncomeSources extends StatefulWidget {
  const ShowIncomeSources({Key? key}) : super(key: key);

  @override
  State<ShowIncomeSources> createState() => _ShowIncomeSourcesState();
}

class _ShowIncomeSourcesState extends State<ShowIncomeSources> {
  late IncomeSourceCubit _incomeSourceCubit;
  void _addSource() => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const CreateSource(),
        ),
      );

  @override
  void initState() {
    super.initState();
    _incomeSourceCubit = BlocProvider.of<IncomeSourceCubit>(context);
    _incomeSourceCubit.getIncomeSources();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income Sources'),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocBuilder<IncomeSourceCubit, IncomeSourceState>(
            builder: (context, state) {
              if (state is IncomeStateSuccess) {
                return AnimatedList(
                  key: _incomeSourceCubit.incomeListKey,
                  itemBuilder: (context, index, animation) => SlideTransition(
                    position: animation.drive<Offset>(offset),
                    child: FadeTransition(
                      opacity: animation.drive<double>(opacity),
                      child: IncomeSourceCard(
                        source: state.data![index],
                      ),
                    ),
                  ),
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
          )
          // categoriesImage,
          // Expanded(
          //   child: AnimatedList(
          //       itemBuilder: (context, index, animation) => SizedBox()),
          // ),

          ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(size.width, 50),
            primary: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: _addSource,
          child: const Text('Add Source'),
        ),
      ),
    );
  }
}
