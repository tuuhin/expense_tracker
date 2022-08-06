import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/utils/app_images.dart';
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
  bool loadMore = false;

  void _scrollListener() async {
    if (_scrollController.offset >
            _scrollController.position.maxScrollExtent * 0.9 &&
        !loadMore) {
      if (_entries.nextURL == null) return;
      loadMore = !loadMore;
      await _entries.getMoreEntries(_entries.nextURL!);
      if (_entries.nextURL == null) return;
      loadMore = !loadMore;
    }
  }

  @override
  void initState() {
    super.initState();

    _entries = BlocProvider.of<EntriesCubit>(context);
    _scrollController = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _entries.getEntires();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Your Entries',
          style: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<EntriesCubit, EntriesState>(
          builder: (context, state) {
            if (state is EntriesLoad) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 10),
                  Text('Loading', style: Theme.of(context).textTheme.subtitle1),
                ],
              );
            }
            if (state is EntriesLoadSuccess) {
              if (state.data.isEmpty) {
                return Center(
                  child: EmptyList(
                    title: 'Haven\'t you add any expense or income',
                    image: categoriesImage,
                  ),
                );
              }
              return AnimatedList(
                controller: _scrollController,
                key: _entries.entriesKey,
                itemBuilder: (context, index, animation) {
                  return FadeTransition(
                    opacity: animation.drive(opacity),
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: EntriesCard(model: state.data[index]),
                    ),
                  );
                },
              );
            }
            if (state is EntriesLoadFailed) {
              logger.shout(state.message);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
