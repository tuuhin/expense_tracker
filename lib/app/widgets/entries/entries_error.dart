import 'package:flutter/material.dart';

class EntriesError extends StatelessWidget {
  final VoidCallback? onRefresh;
  const EntriesError({Key? key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/flaticons/error.png"),
            Text("Failed to load entries",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(letterSpacing: -1, fontWeight: FontWeight.w600)),
            Text("There is a error when entires are queried",
                style: Theme.of(context).textTheme.caption),
            if (onRefresh != null)
              TextButton(
                onPressed: onRefresh,
                child: Text(
                  "Try again",
                  style: TextStyle(
                      color: Colors.red[400], fontWeight: FontWeight.bold),
                ),
              )
          ],
        ),
      ),
    );
  }
}
