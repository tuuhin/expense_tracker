import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/models/auth/user_profile_model.dart';
import '../../../domain/repositories/user_profile_repository.dart';

class AsyncUserProfileImage extends StatelessWidget {
  const AsyncUserProfileImage({super.key});

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: context.read<UserProfileRepository>().getProfile(),
        builder:
            (BuildContext context, AsyncSnapshot<UserProfileModel?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data?.photoURL != null) {
              return AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  fadeInCurve: Curves.bounceIn,
                  fadeOutCurve: Curves.bounceOut,
                  fadeInDuration: const Duration(milliseconds: 100),
                  fadeOutDuration: const Duration(microseconds: 100),
                  imageUrl: snapshot.data!.photoURL!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: Colors.black12,
                  ),
                ),
              );
            }
            return AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(color: Colors.black12),
                child: const FaIcon(FontAwesomeIcons.user),
              ),
            );
          }
          return AspectRatio(
            aspectRatio: 1,
            child: Container(
              height: 12,
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
            ),
          );
        },
      );
}
