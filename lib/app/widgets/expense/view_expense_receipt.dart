import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewExpenseReceipt extends StatelessWidget {
  final String imageURL;

  const ViewExpenseReceipt({Key? key, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Interactive View Mode',
          style: Theme.of(context)
              .appBarTheme
              .titleTextStyle
              ?.copyWith(fontStyle: FontStyle.italic),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Hero(
              tag: imageURL,
              child: InteractiveViewer.builder(
                builder: (context, viewport) => CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? const Color.fromARGB(255, 220, 220, 220)
                                    : const Color.fromARGB(255, 118, 118, 118),
                          ),
                        ),
                    imageUrl: imageURL),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
