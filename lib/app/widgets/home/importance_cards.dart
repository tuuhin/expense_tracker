import 'package:flutter/material.dart';

class ImportanceCard extends StatelessWidget {
  final Image image;
  final String title;
  final void Function()? onTap;
  const ImportanceCard(
      {Key? key, required this.image, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.45,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image,
                const SizedBox(height: 10),
                Text(title, style: Theme.of(context).textTheme.subtitle1)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
