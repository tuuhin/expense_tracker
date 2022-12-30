import 'package:flutter/cupertino.dart';

Route appRouteBuilder(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        final Animation<double> opactity =
            Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );
        final Animation<Offset> offset =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );
        return SlideTransition(
          position: offset,
          child: FadeTransition(opacity: opactity, child: child),
        );
      },
    );

final Tween<Offset> offset =
    Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero);
final Tween<double> opacity = Tween<double>(begin: 0, end: 1);
