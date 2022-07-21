import 'package:flutter/cupertino.dart';

class IncomeSourceModel {
  final int id;
  final String title;
  final String? desc;
  final bool? isSecure;
  IncomeSourceModel(
      {required this.id, required this.title, this.desc, this.isSecure});

  @override
  String toString() => '$id. $title';
}
