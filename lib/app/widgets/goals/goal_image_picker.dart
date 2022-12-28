import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/app/widgets/drop_image_shadow.dart';
import 'package:flutter/material.dart';

class GoalImagePicker extends StatelessWidget {
  final String? imageURL;
  final File? file;

  const GoalImagePicker({
    Key? key,
    this.imageURL,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                      Icon(Icons.camera, color: Colors.black26),
                      Text(
                        'Add Image',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: Colors.black26),
                      )
                    ],
                  ),
                )
              : DropImageShadow(
                  scale: 1,
                  offset: const Offset(10, 10),
                  blurRadius: 10,
                  borderRadius: 10,
                  image: Image(
                    image: CachedNetworkImageProvider(
                      imageURL!,
                    ),
                    height: size.height * .3,
                    width: size.height * .3,
                    fit: BoxFit.cover,
                  ),
                )
          : DropImageShadow(
              scale: 1,
              offset: const Offset(10, 10),
              blurRadius: 10,
              borderRadius: 10,
              image: Image.file(
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
// ClipRRect(
//                   borderRadius: BorderRadius.circular(size.height * .125),
//                   child: CachedNetworkImage(
//                     alignment: Alignment.center,
//                     imageUrl: imageURL!,
//                     height: size.height * .2,
//                     width: size.height * .2,
//                     fit: BoxFit.cover,
//                     errorWidget: (context, url, error) => Container(
//                       color: Colors.black26,
//                     ),
//                   ),
//                 )