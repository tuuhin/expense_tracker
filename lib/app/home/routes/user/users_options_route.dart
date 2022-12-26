import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';
import '../../../widgets/user/theme_settings.dart';

class UserOptionsRoute extends StatelessWidget {
  const UserOptionsRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: kToolbarHeight * 1.5,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withOpacity(0.75),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset.zero,
                      blurRadius: 10,
                      spreadRadius: 5)
                ],
              ),
              child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: const Icon(Icons.arrow_back)),
            ),
          ),
        ),
        body: const CustomScrollView(
          slivers: [
            UserOptionsHeader(),
            ApplicationSettings(),
            AccountSettings(),
            ThemeSettings(),
          ],
        ),
      );
}
