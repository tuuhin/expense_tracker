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
  late Animation<Offset> _offset;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _offset =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(400, 400))
            .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scale = Tween<double>(begin: 1, end: 0.5).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ));
    _rotation = Tween<double>(begin: 0, end: 12).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
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
                  ..rotateZ(radians(_rotation.value * -1)),
                child: Transform.translate(
                    offset: _offset.value,
                    child: Home(controller: _controller)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
