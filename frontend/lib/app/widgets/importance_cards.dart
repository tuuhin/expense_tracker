import 'package:flutter/material.dart';

class ImportanceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const ImportanceCard({Key? key, required this.icon, required this.title})
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Icon(icon, size: 35),
                  )),
              const SizedBox(height: 10),
              Text(title, style: Theme.of(context).textTheme.subtitle1)
            ],
          ),
        ),
      ),
    );
  }
}
