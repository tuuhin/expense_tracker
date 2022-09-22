import 'dart:io';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptPicker extends StatefulWidget {
  final void Function(File?) setFile;
  const ReceiptPicker({Key? key, required this.setFile}) : super(key: key);

  @override
  State<ReceiptPicker> createState() => _ReceiptPickerState();
}

class _ReceiptPickerState extends State<ReceiptPicker> {
  void _pickImageFromCamera() async {
    try {
      XFile? file = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 80);
      if (file?.path == null) return;
      widget.setFile(File(file!.path));
    } catch (e) {
      logger.shout(e.toString());
    }
  }

  void _pickImageFromGallery() async {
    try {
      XFile? file = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (file?.path == null) return;
      widget.setFile(File(file!.path));
    } catch (e) {
      logger.shout(e.toString());
    }
  }

  void _clearImage() => widget.setFile(null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: _pickImageFromCamera,
            trailing: const Icon(Icons.camera_alt_outlined),
            title: const Text('Choose Camera'),
            subtitle: const Text('Pick an image via cammera'),
          ),
          ListTile(
            onTap: _pickImageFromGallery,
            trailing: const Icon(Icons.photo_outlined),
            title: const Text('Choose Gallery'),
            subtitle: const Text('Pick Image from gallery'),
          ),
          ListTile(
            selected: true,
            trailing: const Icon(Icons.remove_circle_outline),
            selectedColor: Colors.red,
            onTap: _clearImage,
            title: const Text('Remove'),
            subtitle: const Text('Remove the image'),
          ),
        ],
      ),
    );
  }
}
