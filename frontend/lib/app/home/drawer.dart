import 'package:expense_tracker/app/home/settings.dart';
import 'package:expense_tracker/app/home/home.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _offsetX;
  late Animation<double> _offsetY;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _offsetX = Tween<double>(begin: 0, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _offsetY = Tween<double>(begin: 0, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scale = Tween<double>(begin: 1, end: 0.65)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotation = Tween<double>(begin: 0, end: 25).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, builder) => Stack(
            children: [
              FadeTransition(opacity: _controller, child: const Settings()),
              Transform(
                transform: Matrix4.identity()
                  ..scale(_scale.value)
                  ..translate(_offsetX.value, _offsetY.value)
                  ..rotateZ(radians(-1 * _rotation.value)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(_rotation.value),
                    child: Home(controller: _controller)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
