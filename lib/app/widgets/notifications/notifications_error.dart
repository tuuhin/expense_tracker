import 'package:flutter/material.dart';

class NotificationsError extends StatelessWidget {
  final VoidCallback? onRefresh;
  const NotificationsError({Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/icons/notification.png"),
              Text("Failed to load notifications",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      letterSpacing: -1, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text("There is a error when notification are queried",
                  style: Theme.of(context).textTheme.caption),
              if (onRefresh != null)
                TextButton(
                  onPressed: onRefresh,
                  child: Text(
                    "Try again",
                    style: TextStyle(
                        color: Colors.yellow[700], fontWeight: FontWeight.bold),
                  ),
                )
            ],
          ),
        ),
      );
}
