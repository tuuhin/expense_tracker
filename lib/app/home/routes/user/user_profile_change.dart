import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../main.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../../../context/context.dart';
import '../../../../domain/models/models.dart';

class ChangeUserProfile extends StatefulWidget {
  final UserProfileModel? profile;
  const ChangeUserProfile({Key? key, this.profile}) : super(key: key);

  @override
  State<ChangeUserProfile> createState() => _ChangeUserProfileState();
}

class _ChangeUserProfileState extends State<ChangeUserProfile> {
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _email;
  late TextEditingController _phoneNumber;
  late String? _imageURL;
  late DateTime? _createdAt;
  late DateTime? _updatedAt;

  File? _file;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _pickImage(ImageSource source) async {
    try {
      XFile? file = await ImagePicker().pickImage(source: source);
      if (file == null) return;
      setState(() => _file = File(file.path));
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
        builder: (context) => ImagePickerModal(
          camera: () => _pickImage(ImageSource.camera),
          gallery: () => _pickImage(ImageSource.gallery),
          clear: _clearImage,
        ),
      );

  void _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<ProfileCubit>().updateProfile(
          UserProfileModel(
            firstName: _firstName.text,
            lastName: _lastName.text,
            updatedAt: DateTime.now(),
            photoURL: _file?.path,
            email: _email.text.isEmpty ? null : _email.text,
            phoneNumber:
                _phoneNumber.text.isEmpty ? null : int.parse(_phoneNumber.text),
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _firstName = TextEditingController(text: widget.profile?.firstName ?? '');
    _lastName = TextEditingController(text: widget.profile?.lastName ?? '');
    _email = TextEditingController(text: widget.profile?.email ?? '');
    _phoneNumber = TextEditingController(
        text: widget.profile?.phoneNumber?.toString() ?? '');

    _imageURL = widget.profile?.photoURL;
    _createdAt = widget.profile?.createdAt;
    _updatedAt = widget.profile?.updatedAt;
    // });
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
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) => state.whenOrNull(
          successful: (message) => ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(message)),
            ),
          requesting: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Updating your profile"))),
          unSuccessful: (err, message) => ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message))),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "Complete your profile",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _imagePickerSheet,
                      child:
                          ChangeProfileHeader(imageURL: _imageURL, file: _file),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400))
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: Form(
                key: _formKey,
                child: UserProfileForm(
                  firstName: _firstName,
                  lastName: _lastName,
                  email: _email,
                  phoneNumber: _phoneNumber,
                ),
              ),
            ),
          ],
        ),
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
