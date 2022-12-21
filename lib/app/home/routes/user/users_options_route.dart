import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../../../widgets/user/theme_settings.dart';

class UserOptionsRoute extends StatelessWidget {
  const UserOptionsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: SizedBox(
                  height: size.height * .4, child: const AsyncProfileImage())),
          const SliverToBoxAdapter(child: ApplicationSettings()),
          const SliverToBoxAdapter(child: AccountSettings()),
          const SliverToBoxAdapter(child: ThemeSettings())
        ],
      ),
    );
  }
}
