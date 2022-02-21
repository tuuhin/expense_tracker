import 'package:flutter/material.dart';

class EntriesOptions extends StatefulWidget {
  final void Function()? onRefresh;
  final void Function()? onPrevious;
  final void Function()? onNext;
  final bool isVisible;
  const EntriesOptions({
    Key? key,
    this.onRefresh,
    this.onPrevious,
    this.onNext,
    required this.isVisible,
  }) : super(key: key);

  @override
  _EntriesOptionsState createState() => _EntriesOptionsState();
}

class _EntriesOptionsState extends State<EntriesOptions>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _offset;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _scale = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));
    _offset = Tween<double>(begin: 0, end: 100).animate(
        CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) => Stack(
              alignment: Alignment.topCenter,
              children: [
                Transform.scale(
                  scale: _scale.value,
                  child: Transform.translate(
                    offset: Offset(-_offset.value, 0),
                    child: IconButton(
                        iconSize: 30,
                        onPressed: widget.onNext,
                        icon: const Icon(Icons.skip_previous)),
                  ),
                ),
                Transform.scale(
                    scale: _scale.value,
                    child: Transform.translate(
                      offset: Offset(_offset.value, 0),
                      child: IconButton(
                          iconSize: 30,
                          onPressed: widget.onNext,
                          icon: const Icon(Icons.skip_next)),
                    )),
                Transform.scale(
                  scale: _scale.value,
                  child: FloatingActionButton(
                      mini: true,
                      heroTag: 'refresh',
                      onPressed: widget.onRefresh,
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.white,
                      )),
                ),
              ],
            ));
  }
}
