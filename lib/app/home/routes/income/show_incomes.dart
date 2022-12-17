import 'package:expense_tracker/app/widgets/ui_event_dialog_error.dart';
import 'package:expense_tracker/domain/models/income/income_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../context/context.dart';
import '../../../widgets/base_error.dart';
import '../../../widgets/loading_shimmer.dart';
import '../../../widgets/no_data_widget.dart';
import './incomes.dart';

class ShowIncomes extends StatefulWidget {
  const ShowIncomes({Key? key}) : super(key: key);

  @override
  State<ShowIncomes> createState() => _ShowIncomesState();
}

class _ShowIncomesState extends State<ShowIncomes> {
  void _addIncome() => context.push("/create-income");

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
        child:
            BlocListener<UiEventCubit<IncomeModel>, UiEventState<IncomeModel>>(
          bloc: context.read<IncomeCubit>().uiEvent,
          listener: (context, state) => state.whenOrNull(
            showSnackBar: (message, data) => ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(message)),
              ),
            showDialog: (message, content, data) => showDialog(
                context: context,
                builder: (context) =>
                    UiEventDialog(title: message, content: content)),
          ),
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(title: Text('Incomes')),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: BlocConsumer<IncomeCubit, IncomeState>(
                  buildWhen: (previous, current) => previous != current,
                  listener: (context, state) => state.whenOrNull(
                    errorWithData: (errMessage, err, _) =>
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(errMessage))),
                    error: (errMessage, err) => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(errMessage))),
                  ),
                  builder: (context, state) => state.when(
                    loading: () => const LoadingShimmer(),
                    noData: (message) =>
                        SliverFillRemaining(child: NoDataWidget.categories()),
                    data: (data, message) => Incomes(incomes: data),
                    error: (errMessage, err) => SliverFillRemaining(
                        child: BaseError(message: errMessage, error: err)),
                    errorWithData: (_, __, data) => Incomes(incomes: data),
                  ),
                ),
              ),
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
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: _addIncome,
              child: const Text('Add Income')),
        ),
      ),
    );
  }
}
