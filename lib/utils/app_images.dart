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
Image categoriesImage = Image.asset('assets/flaticons/category.png');

Image wallet(Color? color) => Image.asset(
      'assets/flaticons/wallet.png',
      color: color,
    );
Image sadFace = Image.asset('assets/flaticons/sad.png');

Image reminderImage = Image.asset('assets/flaticons/reminder.png');

Image budgetImage = Image.asset('assets/flaticons/budget.png');

Image goalsImage = Image.asset('assets/flaticons/piggy-bank.png');

Image sadImage = Image.asset('assets/flaticons/sad.png');

Image categoryImage = Image.asset('assets/flaticons/category.png');

Image anxietyImage = Image.asset('assets/flaticons/anxiety.png');

Image decreaseConcentration =
    Image.asset('assets/flaticons/decreased-concentration.png');

Image sadnessImage = Image.asset('assets/flaticons/sadness.png');

Image noMoneyImage = Image.asset('assets/flaticons/no-money.png');
