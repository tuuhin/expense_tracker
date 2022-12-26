import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PlanningCards extends StatefulWidget {
  const PlanningCards({Key? key}) : super(key: key);

  @override
  State<PlanningCards> createState() => _PlanningCardsState();
}

class _PlanningCardsState extends State<PlanningCards> {
  void _budgetPage() => context.push('/budgets');

  void _goalPage() => context.push('/goals');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text('Planning',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.w600)),
          ),
        ),
        SizedBox(
          height: size.height * .2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * .46,
                height: double.maxFinite,
                child: Card(
                  child: InkWell(
                    onTap: _budgetPage,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/flaticons/credit-limit.png',
                            scale: 1.5),
                        const SizedBox(height: 10),
                        Text(
                          'Budget',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.w600),
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
                    borderRadius: BorderRadius.circular(10),
                    onTap: _goalPage,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/flaticons/target.png', scale: 1.5),
                        const SizedBox(height: 10),
                        Text('Goals',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
