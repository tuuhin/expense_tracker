import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final Image image;
  final String? subtitle;
  final String title;
  const NoDataWidget({
    Key? key,
    required this.title,
    required this.image,
    this.subtitle,
  }) : super(key: key);

  factory NoDataWidget.categories() => NoDataWidget(
        title: 'No categories Present',
        subtitle:
            'It\'s better to have categories those allow you to understand your expenses better ',
        image: Image.asset('assets/flaticons/decreased-concentration.png'),
      );

  factory NoDataWidget.expenses() => NoDataWidget(
        title: "You haven't made any expenses",
        subtitle: "It's seems that you haven't record any of your expenses ",
        image: Image.asset('assets/flaticons/no-money.png'),
      );

  factory NoDataWidget.budget() => NoDataWidget(
        title: "You haven't made any expenses",
        subtitle: "It's seems that you haven't record any of your expenses ",
        image: Image.asset('assets/flaticons/no-money.png'),
      );

  factory NoDataWidget.sources() => NoDataWidget(
        title: "You dont have any sources",
        image: Image.asset('assets/flaticons/no-money.png'),
      );

  factory NoDataWidget.entries() => NoDataWidget(
        title: "No entries present",
        subtitle:
            "No entries found seems like you dont added any expense or incomes",
        image: Image.asset('assets/flaticons/piggy-bank.png'),
      );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image,
            const SizedBox(height: 10),
            Text(title, style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 10),
            if (subtitle != null)
              Text(
                subtitle!,
                style: Theme.of(context).textTheme.caption,
                textAlign: TextAlign.center,
              )
          ],
        ),
      ),
    );
  }
}
