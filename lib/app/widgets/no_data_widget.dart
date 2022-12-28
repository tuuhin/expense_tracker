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

  factory NoDataWidget.goals() => NoDataWidget(
        title: "No Goal found",
        subtitle: "No goal found.Start by creating a goal",
        image: Image.asset('assets/flaticons/graph.png'),
      );

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              Text(title,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold, letterSpacing: -0.25)),
              if (subtitle != null)
                SizedBox(
                  width: 300,
                  child: Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
