import 'package:flutter/cupertino.dart';

Route appRouteBuilder(Widget child) => PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 700),
      reverseTransitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        final Animation<double> _opactity =
            Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );
        final Animation<Offset> _offset =
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))
                .animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );
        return SlideTransition(
          position: _offset,
          child: FadeTransition(opacity: _opactity, child: child),
        );
      },
    );
