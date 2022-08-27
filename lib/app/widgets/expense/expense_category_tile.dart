import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';

class ExpenseCategoryListTile extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  const ExpenseCategoryListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.id,
  }) : super(key: key);

  @override
  State<ExpenseCategoryListTile> createState() =>
      _ExpenseCategoryListTileState();
}

class _ExpenseCategoryListTileState extends State<ExpenseCategoryListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _style;
  late Animation<double> _opacity;
  late ExpenseCategoriesCubit _cubit;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ExpenseCategoriesCubit>(context);
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _opacity = Tween<double>(end: 1, begin: 0.5).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    _style = TextStyleTween(
            end: const TextStyle(
              fontStyle: FontStyle.normal,
            ),
            begin: const TextStyle(
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.lineThrough))
        .animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0, 0.7, curve: Curves.decelerate)));
  }

  void _onTap() {
    // if (!_isChecked) {
    //   _controller.forward();
    //   _cubit.addToSelected(widget.id);
    // } else {
    //   _controller.reverse();
    //   _cubit.removeFromSelected(widget.id);
    // }
    // setState(() {
    //   _isChecked = !_isChecked;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _opacity.value,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          onTap: _onTap,
          trailing: Checkbox(
            onChanged: (bool? value) {},
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            value: _isChecked,
          ),
          title: Text(
            widget.title,
            style: _style.value,
          ),
          subtitle: Text(
            widget.subtitle,
            style: _style.value,
          ),
        ),
      ),
    );
  }
}
