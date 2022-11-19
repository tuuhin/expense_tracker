import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../context/context.dart';
import '../../../../utils/app_images.dart';
import '../../../widgets/loading/list_loading_shimmer.dart';
import '../../../widgets/widgets.dart';
import '../routes.dart';
import './budgets.dart';

class ShowBudget extends StatefulWidget {
  const ShowBudget({Key? key}) : super(key: key);

  @override
  State<ShowBudget> createState() => _ShowBudgetState();
}

class _ShowBudgetState extends State<ShowBudget> {
  late BudgetCubit _budgetCubit;

  void _addShowBudget() =>
      Navigator.of(context).push(appRouteBuilder(const CreateBudget()));

  @override
  void initState() {
    super.initState();
    _budgetCubit = BlocProvider.of<BudgetCubit>(context);
    _budgetCubit.getBudgetInfo();
  }

  Future<void> _refreshData() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refresh your Budgets'),
        content: const Text('You can refresh your budgets'),
        actions: [
          TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async => await context
                .read<BudgetCubit>()
                .getBudgetInfo()
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
      appBar: AppBar(title: const Text('Budgets')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                    'A budget hepls you to track the expenses ,it mainly acts as a limit that u cannot cross.',
                    style: Theme.of(context).textTheme.caption),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: BlocConsumer<BudgetCubit, BudgetState>(
                buildWhen: (previous, current) => previous != current,
                listenWhen: (previous, current) => current is BudgetLoadFailed,
                listener: (context, state) {
                  if (state is BudgetLoadFailed && state.data != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is BudgetLoadSuccess) {
                    if (state.data.isNotEmpty) {
                      return Budgets(models: state.data);
                    }
                    return SliverFillRemaining(
                      child: Center(
                        child: EmptyList(
                          title: 'Oh! no I have no imcomes',
                          subtitle:
                              'You should definitly start earning some money',
                          image: noMoneyImage,
                        ),
                      ),
                    );
                  }
                  if (state is BudgetLoadFailed) {
                    if (state.data != null) {
                      return Budgets(models: state.data!);
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
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 50),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            onPressed: _addShowBudget,
            icon: const Icon(Icons.add),
            label: const Text('Add Budget'),
          ),
        ),
      ),
    );
  }
}
