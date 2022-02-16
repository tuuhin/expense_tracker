import 'package:expense_tracker/services/cubits/income_sources/income_source_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetIncomeSources extends StatefulWidget {
  const GetIncomeSources({Key? key}) : super(key: key);

  @override
  State<GetIncomeSources> createState() => _GetIncomeSourcesState();
}

class _GetIncomeSourcesState extends State<GetIncomeSources> {
  void _close(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    final double _screenY = MediaQuery.of(context).size.height;
    final IncomeSourceCubit _incomeSources =
        BlocProvider.of<IncomeSourceCubit>(context);
    return SizedBox(
      height: _screenY * .5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              trailing: IconButton(
                  onPressed: () => _incomeSources.refreshSources(),
                  icon: const Icon(Icons.refresh)),
              title: const Text('Choose your sources'),
            ),
            BlocBuilder<IncomeSourceCubit, IncomeSourceState>(
              builder: (context, state) {
                if (state is IncomeSourceLoad) {
                  _incomeSources.loadData();
                  return const CircularProgressIndicator();
                }
                if (state is IncomeSourceLoaded) {
                  return Expanded(
                      child: ListView.builder(
                          itemCount: state.models.length,
                          itemBuilder: (context, int item) => ListTile(
                                title: Text(state.models[item]!.title),
                                subtitle: Text(state.models[item]!.desc ?? ''),
                              )));
                }
                if (state is IncomeSourceLoadFailed) {
                  return const Icon(Icons.no_backpack);
                }
                return const SizedBox();
              },
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    fixedSize: Size(_screenX, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                onPressed: () => _close(context),
                child: Text('Done',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
