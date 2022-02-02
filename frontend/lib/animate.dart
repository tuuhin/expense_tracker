import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' show radians;

class AnimateFile extends StatefulWidget {
  const AnimateFile({Key? key}) : super(key: key);

  @override
  _AnimateFileState createState() => _AnimateFileState();
}

class _AnimateFileState extends State<AnimateFile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translate;
  late Animation<double> _scale;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _translate = Tween<double>(begin: 0.0, end: 100).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceInOut));
    _scale = Tween<double>(begin: 1.0, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _rotation = Tween<double>(begin: 0.0, end: 360)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    print('controller disposed');
    super.dispose();
  }

  _forward() {
    _controller.forward();
  }

  _reverse() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: radians(_rotation.value),
          child: Stack(alignment: Alignment.center, children: [
            Transform.translate(
              offset: Offset(_translate.value * -1, 0),
              child: FloatingActionButton(
                  heroTag: "purple button",
                  backgroundColor: Colors.purple,
                  elevation: 0,
                  onPressed: () {
                    print('hu');
                  },
                  child: const Icon(Icons.settings)),
            ),
            Transform.translate(
              offset: Offset(_translate.value, 0),
              child: FloatingActionButton(
                  heroTag: "pink button",
                  backgroundColor: Colors.pink,
                  elevation: 0,
                  onPressed: () {
                    print('cliekc');
                  },
                  child: const Icon(Icons.home)),
            ),
            Transform.translate(
              offset: Offset(0, _translate.value * -1),
              child: FloatingActionButton(
                  heroTag: "yellow button",
                  backgroundColor: Colors.yellow,
                  elevation: 0,
                  onPressed: () async {
                    await Navigator.of(context).push(
                      PageRouteBuilder(
                          transitionDuration:
                              const Duration(milliseconds: 2000),
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const Page2(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            final _offset = Tween<double>(begin: 0.0, end: 1.0)
                                .animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.decelerate));
                            return ScaleTransition(
                              scale: _offset,
                              child: child,
                            );
                          }),
                    );
                  },
                  child: const Icon(Icons.settings)),
            ),
            Transform.translate(
              offset: Offset(0, _translate.value),
              child: FloatingActionButton(
                  heroTag: "green button",
                  backgroundColor: Colors.green,
                  elevation: 0,
                  onPressed: _reverse,
                  child: const Icon(Icons.home)),
            ),
            Transform.scale(
              scale: _scale.value,
              child: FloatingActionButton(
                  heroTag: "add button",
                  onPressed: _forward,
                  child: const Icon(Icons.add)),
            ),
          ]),
        );
      },
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New page"),
          centerTitle: true,
        ),
        body: SizedBox.expand(
          child: AnimatedList(
            initialItemCount: 10,
            itemBuilder: (context, index, animation) {
              final _pos = Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
                  .animate(CurvedAnimation(
                      parent: animation, curve: Curves.decelerate));
              return SlideTransition(
                position: _pos,
                child: ListTile(
                  title: Text('$index'),
                ),
              );
            },
          ),
        ));
  }
}
