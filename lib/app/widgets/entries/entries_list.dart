import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/domain/models/entries_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntriesList extends StatefulWidget {
  final List<EntriesModel> entries;
  final ScrollController controller;
  const EntriesList({
    Key? key,
    required this.entries,
    required this.controller,
  }) : super(key: key);

  @override
  _EntriesListState createState() => _EntriesListState();
}

class _EntriesListState extends State<EntriesList> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  // ignore: prefer_final_fields
  List<EntriesTitle> _tiles = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //This function will call  will occur after the build methid has run
      Future future = Future(() {});
      for (var entry in widget.entries) {
        future = future
            .then((_) => Future.delayed(const Duration(milliseconds: 50), () {
                  _tiles.add(EntriesTitle(
                    title: entry.title,
                    type: entry.type,
                    desc: entry.desc,
                  ));
                  _key.currentState!.insertItem(_tiles.length - 1);
                }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Tween<Offset> _offset =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));
    return AnimatedList(
      physics: const BouncingScrollPhysics(),
      controller: widget.controller,
      key: _key,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: animation.drive(_offset),
          child: _tiles[index],
        );
      },
    );
  }
}
