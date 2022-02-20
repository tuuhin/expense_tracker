import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/services/cubits/entries/entries_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntriesTab extends StatefulWidget {
  const EntriesTab({Key? key}) : super(key: key);

  @override
  State<EntriesTab> createState() => _EntriesTabState();
}

class _EntriesTabState extends State<EntriesTab> {
  late EntriesCubit _entries;
  late ScrollController _scrollController;
  bool isOptionsVisible = false;

  @override
  void initState() {
    super.initState();
    _entries = BlocProvider.of<EntriesCubit>(context);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: BlocBuilder<EntriesCubit, EntriesState>(builder: (context, state) {
        if (state is EntriesLoad) {
          _entries.loadEntries();
          return const Center(child: CircularProgressIndicator());
        }
        if (state is EntriesLoadSuccess) {
          return Stack(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
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
                  const Divider(),
                  Expanded(
                    child: AnimatedList(
                        controller: _scrollController,
                        initialItemCount: state.entries.length,
                        itemBuilder: (context, index, animation) {
                          final Animation<Offset> _offset = Tween<Offset>(
                                  begin: const Offset(-1, 0),
                                  end: const Offset(0, 0))
                              .animate(CurvedAnimation(
                                  parent: animation, curve: Curves.decelerate));

                          return SlideTransition(
                            position: _offset,
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Text('$index'),
                              trailing: Icon(
                                Icons.badge,
                                color: state.entries[index].type == 'income'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              title: Text(state.entries[index].title),
                              subtitle: Text(state.entries[index].desc ?? ''),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
            AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isOptionsVisible ? 1 : 0,
                child: const EntriesOptions()),
            ElevatedButton(
                onPressed: () {}, child: Text('hellow where are you'))
          ]);
        }
        return const SizedBox();
      }),
    );
  }
}
