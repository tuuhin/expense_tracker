import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChangeProfileHeader extends StatelessWidget {
  final String? imageURL;
  final File? file;

  const ChangeProfileHeader({
    Key? key,
    this.imageURL,
    this.file,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        if (imageURL == null && file?.path == null)
          Container(
            alignment: Alignment.center,
            height: size.height * .2,
            width: size.height * .2,
            decoration: const BoxDecoration(
                color: Colors.black12, shape: BoxShape.circle),
            child: const FaIcon(FontAwesomeIcons.user, size: 50),
          ),
        if (file?.path == null && imageURL != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(size.height * .125),
            child: CachedNetworkImage(
              alignment: Alignment.center,
              imageUrl: imageURL!,
              height: size.height * .2,
              width: size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
        if (file?.path != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(size.height * .125),
            child: Image.file(
              file!,
              alignment: Alignment.center,
              height: size.height * .2,
              width: size.height * .2,
              fit: BoxFit.cover,
            ),
          ),
        Positioned(
          bottom: -2,
          right: 12,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.secondary,
              border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor, width: 4),
            ),
          ),
        ),
      ],
    );
  }
}
