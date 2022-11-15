import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../domain/models/auth/user_profile_model.dart';
import '../../../../domain/repositories/user_profile_repository.dart';
import '../../../../main.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/validators.dart';
import '../../../widgets/user/change_profile_header.dart';
import '../../../../utils/date_formaters.dart';

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

  String? _imageURL;
  File? _file;
  DateTime? _createdAt;
  DateTime? _updatedAt;

  void _pickImage(ImageSource source) async {
    try {
      XFile? file = await ImagePicker().pickImage(source: source);
      if (file == null) return;
      setState(() {
        _file = File(file.path);
      });
    } on PlatformException {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
            const SnackBar(content: Text("Platform exception occured")));
    } catch (e) {
      logger.severe(e);
    }
  }

  void _clearImage() => setState(() {
        if (_imageURL != null) {
          _imageURL = null;
        }
        _file = null;
      });

  void _imagePickerSheet() async => await showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  selected: true,
                  onTap: () => _pickImage(ImageSource.camera),
                  title: const Text('Camera'),
                  leading: const Icon(Icons.camera_alt_outlined)),
              const Divider(height: 1),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  selected: true,
                  onTap: () => _pickImage(ImageSource.gallery),
                  title: const Text('Gallery'),
                  leading: const Icon(Icons.image)),
              const Divider(height: 1),
              ListTile(
                  contentPadding: EdgeInsets.zero,
                  selected: true,
                  onTap: _clearImage,
                  title: const Text('Remove Image'),
                  leading: const Icon(Icons.hide_image_outlined))
            ],
          ),
        ),
      );

  void _updateProfile() async {
    // FocusScope.of(context).requestFocus(FocusNode());
    if (_firstName.text.isEmpty || _lastName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some fields are missing')),
      );
      return;
    }
    if (_email.text.isNotEmpty && validateEmail(_email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Email!')),
      );
      return;
    }
    if (_phoneNumber.text.isNotEmpty &&
        int.tryParse(_phoneNumber.text) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid Phone number')),
      );

      return;
    }
    Resource<UserProfileModel> update = await context
        .read<UserProfileRepository>()
        .updateProfile(UserProfileModel(
            firstName: _firstName.text,
            lastName: _lastName.text,
            updatedAt: DateTime.now(),
            photoURL: _file?.path,
            email: _email.text.isEmpty ? null : _email.text,
            phoneNumber: _phoneNumber.text.isEmpty
                ? null
                : int.parse(_phoneNumber.text)));

    update.maybeWhen(
      orElse: () {},
      data: (data, message) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message ?? 'Done')));
      },
      error: (err, errorMessage, data) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(errorMessage)));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _phoneNumber = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      UserProfileModel? profile =
          await context.read<UserProfileRepository>().getProfile();
      logger.fine("called");
      setState(() {
        _firstName.text = profile?.firstName ?? '';
        _lastName.text = profile?.lastName ?? '';
        _email.text = profile?.email ?? '';
        _phoneNumber.text = profile?.phoneNumber?.toString() ?? '';
        _imageURL = profile?.photoURL;
        _createdAt = profile?.createdAt;
        _updatedAt = profile?.updatedAt;
      });
    });
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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _imagePickerSheet,
                    child: ChangeProfileHeader(
                      imageURL: _imageURL,
                      file: _file,
                    ),
                  ),
                  const SizedBox(height: kTextTabBarHeight * .5),
                  if (_createdAt != null)
                    Text.rich(
                      TextSpan(
                        text: "Last Updated on: ",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "${_updatedAt?.toSimpleDate()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                  if (_updatedAt != null)
                    Text.rich(
                      TextSpan(
                        text: "Created on: ",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(
                              text: "${_createdAt?.toSimpleDate()}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Personal Information',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                  const Divider(),
                  TextField(
                    controller: _firstName,
                    decoration: const InputDecoration(
                      label: Text('First Name'),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
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
                  const Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         fixedSize: Size(size.width, 50),
                  //         backgroundColor:
                  //             Theme.of(context).colorScheme.secondary),
                  //     onPressed: _updateProfile,
                  //     child: Text('Update',
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .subtitle1!
                  //             .copyWith(color: Colors.white)),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(size.width, 50),
                  backgroundColor: Theme.of(context).colorScheme.secondary),
              onPressed: _updateProfile,
              child: const Text('Update'),
            ),
          )),
    );
  }
}
