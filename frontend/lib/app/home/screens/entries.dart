import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/services/cubits/cubit.dart';
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

  @override
  void initState() {
    super.initState();
    _entries = BlocProvider.of<EntriesCubit>(context);
    _scrollController = ScrollController();

    _scrollController.addListener(() {
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
    });
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
              children: const [CircularProgressIndicator(), Text('Loading')]);
        }
        if (state is EntriesLoadSuccess) {
          return Stack(alignment: Alignment.bottomCenter, children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    trailing:
                        Text('${state.highestCount}/${state.overallCount}'),
                    title: Text('Entries',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w700)),
                  ),
                  state.entries.isNotEmpty
                      ? Expanded(
                          child: AnimatedList(
                              physics: const BouncingScrollPhysics(),
                              controller: _scrollController,
                              initialItemCount: state.entries.length,
                              itemBuilder: (context, index, animation) {
                                final Animation<Offset> _offset = Tween<Offset>(
                                        begin: const Offset(-1, 0),
                                        end: const Offset(0, 0))
                                    .animate(CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.decelerate));

                                return SlideTransition(
                                  position: _offset,
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    trailing: Icon(
                                      Icons.badge,
                                      color:
                                          state.entries[index].type == 'income'
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                    title: Text(state.entries[index].title),
                                    subtitle:
                                        Text(state.entries[index].desc ?? ''),
                                  ),
                                );
                              }),
                        )
                      : const Text('no entries')
                ],
              ),
            ),
            Positioned(
              bottom: 60,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: EntriesOptions(
                  isVisible: _isOptions,
                  onRefresh: () => _entries.emitLoadState(),
                  onNext: () {
                    if (state.nextURL != null) {
                      print(state.previousURL);
                      _entries.loadEntriesByURL(state.nextURL ?? '');
                    }
                  },
                  onPrevious: state.previousURL != null
                      ? () {
                          print(state.previousURL);
                          _entries.loadEntriesByURL(state.previousURL ?? '');
                        }
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
