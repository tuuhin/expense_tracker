import 'package:flutter/material.dart';

class SliverNoDataWidget extends StatelessWidget {
  final Image image;
  final String text;
  final String? helper;
  const SliverNoDataWidget(
      {Key? key, required this.image, required this.text, this.helper})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image,
              Text(text, style: Theme.of(context).textTheme.subtitle1),
              if (helper != null)
                SizedBox(
                  width: 300,
                  child: Text(
                    helper!,
                    style: Theme.of(context).textTheme.caption,
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          ),
        ),
      );
}
