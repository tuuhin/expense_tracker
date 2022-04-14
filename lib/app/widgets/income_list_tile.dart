import 'package:expense_tracker/services/cubits/income_sources/income_source_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomeSourceListTile extends StatefulWidget {
  final int id;
  final String title;
  final String subtitle;
  const IncomeSourceListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.id,
  }) : super(key: key);

  @override
  _IncomeSourceListTileState createState() => _IncomeSourceListTileState();
}

class _IncomeSourceListTileState extends State<IncomeSourceListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<TextStyle> _style;
  late Animation<double> _opacity;
  late IncomeSourceCubit _cubit;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<IncomeSourceCubit>(context);
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
    if (!_isChecked) {
      _controller.forward();
      _cubit.addToSelected(widget.id);
    } else {
      _controller.reverse();
      _cubit.removeFromSelected(widget.id);
    }
    setState(() {
      _isChecked = !_isChecked;
    });
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
