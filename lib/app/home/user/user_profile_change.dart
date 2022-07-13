import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:expense_tracker/app/home/user/profile_app_bar.dart';
import 'package:expense_tracker/utils/utils.dart';

class ChangeUserProfile extends StatefulWidget {
  const ChangeUserProfile({Key? key}) : super(key: key);

  @override
  State<ChangeUserProfile> createState() => _ChangeUserProfileState();
}

class _ChangeUserProfileState extends State<ChangeUserProfile> {
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  File? _image;

  void _pickImage(ImageSource source) async {
    try {
      XFile? _file = await ImagePicker()
          .pickImage(source: source, preferredCameraDevice: CameraDevice.front);
      if (_file == null) return;
      setState(() => _image = File(_file.path));
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  void _imagePickerSheet() => showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                onTap: () => _pickImage(ImageSource.camera),
                title: const Text('Camera'),
                leading: const Icon(Icons.camera_alt)),
            ListTile(
              onTap: () => _pickImage(ImageSource.gallery),
              title: const Text('Gallery'),
              leading: const Icon(Icons.image),
            )
          ],
        ),
      );

  void _updateProfile() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_firstName.text.isEmpty ||
        _lastName.text.isEmpty ||
        _email.text.isEmpty ||
        _phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some fields are missing')),
      );
      return;
    }
    if (validateEmail(_email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Email!')),
      );
      return;
    }
    if (int.tryParse(_phoneNumber.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Phone number')),
      );
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomAppBarDelegate(
                onPressed: _imagePickerSheet,
                expandedHeight: _size.height * .35,
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover)
                    : Container()
                // child: CachedNetworkImage(
                //   imageUrl:
                //       'https://media.gettyimages.com/photos/joe-root-of-england-celebrates-his-century-during-day-four-of-the-picture-id1030463034?s=2048x2048',
                //   fadeInCurve: Curves.easeInBack,
                //   fit: BoxFit.cover,
                //   filterQuality: FilterQuality.medium,
                // ),
                ),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      const Divider(),
                      TextField(
                        controller: _firstName,
                        decoration: const InputDecoration(
                            label: Text('First Name'),
                            prefixIcon: Icon(Icons.person_outline)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _lastName,
                        decoration: const InputDecoration(
                            label: Text('Last  Name'),
                            prefixIcon: Icon(Icons.person_outline)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                            label: Text('Email'),
                            prefixIcon: Icon(Icons.email_outlined)),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _phoneNumber,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            label: Text('Phone number'),
                            prefixIcon: Icon(Icons.phone_android_rounded)),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(_size.width, 50),
              primary: Theme.of(context).colorScheme.secondary),
          onPressed: _updateProfile,
          child: const Text('Update'),
        ),
      )),
    );
  }
}
