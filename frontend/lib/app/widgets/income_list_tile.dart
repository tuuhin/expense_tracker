import 'package:flutter/material.dart';

class IncomeSourceListTile extends StatefulWidget {
  const IncomeSourceListTile({Key? key}) : super(key: key);

  @override
  _IncomeSourceListTileState createState() => _IncomeSourceListTileState();
}

class _IncomeSourceListTileState extends State<IncomeSourceListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _style;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _style = Tween<TextStyle>(
            begin: Theme.of(context).textTheme.bodyText1,
            end: Theme.of(context).textTheme.caption)
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, widget) => ListTile(
            onTap: () => _controller.forward(),
            title: Text(
              'hellow',
              style: _style.value,
            )));
  }
}
