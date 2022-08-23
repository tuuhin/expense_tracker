import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/context/user_info/user_info_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/auth/user_profile_model.dart';

class UserProfileAppBar extends StatelessWidget {
  const UserProfileAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfileModel>(
      future: context.read<UserInfoCubit>().getProfile(),
      builder: (
        BuildContext context,
        AsyncSnapshot<UserProfileModel> snapshot,
      ) {
        bool doPhotoURLExists =
            snapshot.hasData && snapshot.data!.photoURL != null;

        if (doPhotoURLExists) {
          String photoURL = snapshot.data!.photoURL!;
          return AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              fadeOutDuration: const Duration(milliseconds: 100),
              fadeOutCurve: Curves.bounceOut,
              fadeInDuration: const Duration(milliseconds: 100),
              fadeInCurve: Curves.bounceIn,
              imageUrl: photoURL,
              fit: BoxFit.cover,
            ),
          );
        }
        return const FaIcon(FontAwesomeIcons.user);
      },
    );
  }
}
