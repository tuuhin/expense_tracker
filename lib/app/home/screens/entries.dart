import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntriesTab extends StatefulWidget {
  const EntriesTab({Key? key}) : super(key: key);

  @override
  State<EntriesTab> createState() => _EntriesTabState();
}

class _EntriesTabState extends State<EntriesTab> {
  late ScrollController _scrollController;
  late EntriesCubit _entries;
  bool _isOptions = false;

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        !_isOptions) {
      setState(() {
        _isOptions = !_isOptions;
      });
    } else if (_isOptions) {
      setState(() {
        _isOptions = !_isOptions;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _entries = BlocProvider.of<EntriesCubit>(context);
    _scrollController = ScrollController();

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocBuilder<EntriesCubit, EntriesState>(builder: (context, state) {
        if (state is EntriesLoad) {
          _entries.loadEntries();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 10),
              Text(
                'Loading',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ],
          );
        }
        if (state is EntriesLoadSuccess) {
          return Stack(alignment: Alignment.bottomCenter, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                ListTile(
                  trailing: Text(
                    '${state.highestCount}/${state.overallCount}',
                  ),
                  title: Text('Entries',
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w700)),
                ),
                if (state.entries.isNotEmpty)
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: EntriesList(
                          entries: state.entries,
                          controller: _scrollController,
                        )),
                  )
                else
                  const Text('No entries')
              ],
            ),
            Positioned(
              bottom: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EntriesOptions(
                  isVisible: _isOptions,
                  onRefresh: () => _entries.emitLoadState(),
                  onNext: state.nextURL != null
                      ? () => _entries.loadEntriesByURL(state.nextURL)
                      : null,
                  onPrevious: state.previousURL != null
                      ? () => _entries.loadEntriesByURL(state.previousURL)
                      : null,
                ),
              ),
            )
          ]);
        }
        return const SizedBox();
      }),
    );
  }
}
