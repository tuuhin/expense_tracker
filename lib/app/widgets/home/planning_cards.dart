import 'package:flutter/material.dart';

import '../../../utils/app_images.dart';
import '../../home/routes/routes.dart';

class PlanningCards extends StatefulWidget {
  const PlanningCards({Key? key}) : super(key: key);

  @override
  State<PlanningCards> createState() => _PlanningCardsState();
}

class _PlanningCardsState extends State<PlanningCards> {
  void _budgetPage() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ShowBudget()));

  void _goalPage() => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const ShowGoals()));

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: size.width * .46,
            height: double.maxFinite,
            child: Card(
              child: InkWell(
                onTap: _budgetPage,
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
          ),
          // ReminderCard(),
          SizedBox(
            width: size.width * .46,
            height: double.maxFinite,
            child: Card(
              child: InkWell(
                onTap: _goalPage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    goalsImage,
                    const SizedBox(height: 10),
                    Text(
                      'Goals',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
