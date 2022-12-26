import 'package:flutter/material.dart';

import '../widgets.dart';
import '../../../domain/models/models.dart';

class BaseInfoData extends StatelessWidget {
  final UserBaseOverViewModel data;
  const BaseInfoData({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> keys = data.toMap.keys.toList();
    List<double> values = data.toMap.values.toList();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 4,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(right: 15),
        child: BaseInformationCards(
          amount: values[index],
          title: keys[index],
          backGroundColor:
              index % 2 == 0 ? null : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
