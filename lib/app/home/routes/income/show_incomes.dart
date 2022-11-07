import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/empty_list.dart';
import '../../../widgets/loading/list_loading_shimmer.dart';
import '../routes.dart';
import './incomes.dart';

class ShowIncomes extends StatefulWidget {
  const ShowIncomes({Key? key}) : super(key: key);

  @override
  State<ShowIncomes> createState() => _ShowIncomesState();
}

class _ShowIncomesState extends State<ShowIncomes> {
  void _addIncome() => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CreateIncome(),
        ),
      );

  @override
  void initState() {
    super.initState();
    context.read<IncomeCubit>().getIncomes();
  }

  Future<void> _refreshData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh Incomes'),
        content: const Text('You can refresh your incomes'),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('cancel')),
          ElevatedButton(
            onPressed: () => context
                .read<IncomeCubit>()
                .getIncomes()
                .then(Navigator.of(context).pop),
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(title: Text('Incomes')),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: BlocConsumer<IncomeCubit, IncomeState>(
                buildWhen: (previous, current) => previous != current,
                listenWhen: (previous, current) => current is IncomeLoadFailed,
                listener: (context, state) {
                  if (state is IncomeLoadFailed && state.data != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is IncomeLoadSuccess) {
                    if (state.data.isNotEmpty) {
                      return Incomes(models: state.data);
                    }
                    return SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          title: 'Oh! no I have no imcomes',
                          subtitle:
                              'You should definitly start earning some money',
                          image: decreaseConcentration,
                        ),
                      ),
                    );
                  }
                  if (state is IncomeLoadFailed) {
                    if (state.data != null) {
                      return Incomes(models: state.data!);
                    }
                    return SliverFillRemaining(
                      child: Container(
                          height: 200,
                          color: Colors.red,
                          child: Text("ERROR OCCURED ")),
                    );
                  } else {
                    return const ListLoadingShimmer();
                  }
                },
              ),
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
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: _addIncome,
              child: const Text('Add Income')),
        ),
      ),
    );
  }
}
