import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExpenseImagePicker extends StatelessWidget {
  final String? imageURL;
  final File? file;
  const ExpenseImagePicker({Key? key, this.imageURL, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: file?.path == null
            ? imageURL == null
                ? Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.photo_album_outlined, color: Colors.black26),
                        Text(
                          'Add Image',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black26),
                        )
                      ],
                    ),
                  )
                : CachedNetworkImage(
                    imageUrl: imageURL!,
                    height: size.height * .3,
                    width: size.height * .3,
                    fit: BoxFit.cover,
                  )
            : Image.file(
                file!,
                alignment: Alignment.center,
                height: size.height * .2,
                width: size.height * .2,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
