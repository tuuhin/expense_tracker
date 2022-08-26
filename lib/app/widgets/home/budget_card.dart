import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * .5,
      child: Card(
        child: InkWell(
          onTap: () =>
              Navigator.of(context).push(appRouteBuilder(const ShowBudget())),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              budgetImage,
              const SizedBox(height: 10),
              Text(
                'Budget',
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
