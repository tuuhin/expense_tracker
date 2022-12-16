import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewExpenseReceipt extends StatelessWidget {
  final String imageURL;

  const ViewExpenseReceipt({Key? key, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receipt'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: UniqueKey(),
              child: InteractiveViewer.builder(
                builder: (context, viewport) => CachedNetworkImage(
                  alignment: Alignment.center,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? const Color.fromARGB(255, 220, 220, 220)
                          : const Color.fromARGB(255, 118, 118, 118),
                    ),
                  ),
                  imageUrl: imageURL,
                  height: size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
