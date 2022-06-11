import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Image authHomeImage = Image.asset(
  'assets/flaticons/monochrome.png',
  scale: 1.25,
);

final Image signInImage = Image.asset(
  'assets/flaticons/flatline.png',
  scale: 1.25,
);

final Image signUpImage = Image.asset(
  'assets/flaticons/app_flatline.png',
  scale: 1.25,
);

Image authFailed({Color? color}) => Image.asset(
      'assets/flaticons/fail.png',
      color: color,
      scale: 2,
    );
