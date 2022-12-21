import 'package:flutter/material.dart';

class ImagePickerModal extends StatelessWidget {
  final VoidCallback camera;
  final VoidCallback gallery;
  final VoidCallback clear;
  const ImagePickerModal({
    Key? key,
    required this.camera,
    required this.gallery,
    required this.clear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              contentPadding: EdgeInsets.zero,
              selected: true,
              onTap: camera,
              title: const Text('Camera'),
              leading: const Icon(Icons.camera_alt_outlined)),
          const Divider(height: 1),
          ListTile(
              contentPadding: EdgeInsets.zero,
              selected: true,
              onTap: gallery,
              title: const Text('Gallery'),
              leading: const Icon(Icons.image)),
          const Divider(height: 1),
          ListTile(
              contentPadding: EdgeInsets.zero,
              selected: true,
              onTap: clear,
              title: const Text('Remove Image'),
              leading: const Icon(Icons.hide_image_outlined))
        ],
      ),
    );
  }
}
