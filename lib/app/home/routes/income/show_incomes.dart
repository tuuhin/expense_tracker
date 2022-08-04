import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/income/income_card.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';

class ShowIncomes extends StatefulWidget {
  const ShowIncomes({Key? key}) : super(key: key);

  @override
  State<ShowIncomes> createState() => _ShowIncomesState();
}

class _ShowIncomesState extends State<ShowIncomes> {
  late IncomeCubit _incomeCubit;

  void _addIncome() => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const CreateIncome(),
      ));

  @override
  void initState() {
    super.initState();
    _incomeCubit = BlocProvider.of<IncomeCubit>(context);
    _incomeCubit.getIncomes();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kTextTabBarHeight * .1),
            child: Divider()),
        title: const Text('Incomes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<IncomeCubit, IncomeState>(
          builder: (context, state) {
            if (state is IncomeLoadSuccess) {
              if (state.data!.isNotEmpty) {
                return AnimatedList(
                  key: _incomeCubit.key,
                  itemBuilder: (context, index, animation) => SlideTransition(
                    position: animation.drive<Offset>(offset),
                    child: FadeTransition(
                      opacity: animation.drive<double>(opacity),
                      child: IncomeCard(
                        income: state.data![index],
                      ),
                    ),
                  ),
                );
              }
              return Center(
                  child: EmptyList(
                title: 'Oh! no I have no imcomes',
                subtitle: 'You should definitly start earning some money',
                image: decreaseConcentration,
              ));
            }
            if (state is IncomeLoadFailed) {
              return Container(
                  height: 200,
                  color: Colors.red,
                  child: Text(state.message.toString()));
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
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(size.width, 50),
              primary: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: _addIncome,
            child: const Text('Add Income'),
          ),
        ),
      ),
    );
  }
}
