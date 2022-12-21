import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';

class AsyncProfileImage extends StatelessWidget {
  const AsyncProfileImage({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: context.read<ProfileCubit>().streamProfile(),
        builder: (context, AsyncSnapshot<UserProfileModel?> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data?.photoURL != null) {
              return AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  fadeInCurve: Curves.easeIn,
                  fadeOutCurve: Curves.easeOut,
                  imageUrl: snapshot.data!.photoURL!,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
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
              decoration: const BoxDecoration(color: Colors.black12),
            ),
          );
        },
      );
}
