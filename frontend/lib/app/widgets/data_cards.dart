import 'package:flutter/material.dart';

class DataCards extends StatelessWidget {
  final num amount;
  final String title;
  const DataCards({Key? key, required this.amount, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ShapeBorder _border =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25));
    final double _screenX = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _screenX * 0.45,
      child: Card(
        shape: _border,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.account_balance_wallet_rounded, size: 32),
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.subtitle1),
              const Spacer(),
              Text('$amount', style: Theme.of(context).textTheme.headline6)
            ],
          ),
        ),
      ),
    );
  }
}
