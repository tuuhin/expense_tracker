import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../context/context.dart';
import '../../../domain/models/models.dart';
import '../../../utils/utils.dart';
import '../widgets.dart';

class UserOptionsHeader extends StatelessWidget {
  const UserOptionsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SliverToBoxAdapter(
      child: SizedBox(
        height: size.height * .4,
        child: Stack(
          fit: StackFit.expand,
          // alignment: Alignment.bottomCenter,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white, Colors.black],
                tileMode: TileMode.mirror,
              ).createShader(bounds),
              child: AsyncProfileImage(
                image: Image.asset('assets/flaticons/user.png'),
              ),
            ),
            Positioned(
              bottom: 0,
              child: StreamBuilder(
                stream: context.read<ProfileCubit>().streamProfile(),
                builder: (context, AsyncSnapshot<UserProfileModel?> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            snapshot.data!.firstName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            toDate(snapshot.data!.updatedAt),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
