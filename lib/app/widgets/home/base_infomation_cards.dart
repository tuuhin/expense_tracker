import 'package:expense_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

class BaseInformationCards extends StatelessWidget {
  final String title;
  final List<Widget> items;
  final Color? backGroundColor;
  const BaseInformationCards({
    Key? key,
    this.backGroundColor,
    required this.items,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .4,
      child: Card(
        elevation: 10,
        color: backGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              // const Icon(Icons.account_balance_wallet_rounded, size: 32),
              wallet(backGroundColor != null
                  ? Colors.white
                  : Theme.of(context).iconTheme.color),
              const SizedBox(height: 5),
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: backGroundColor != null
                          ? Colors.white
                          : Theme.of(context).iconTheme.color,
                    ),
              ),
              const SizedBox(height: 20),
              ...items
            ],
          ),
        ),
      ),
    );
  }
}
