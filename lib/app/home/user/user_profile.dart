import 'package:flutter/material.dart';
import 'dart:io';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: _size.height * .4,
                child: Stack(
                  fit: StackFit.expand,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      color: Colors.pink,
                    ),
                    // CachedNetworkImage(
                    //   imageUrl:
                    //       'https://media.gettyimages.com/photos/joe-root-of-england-celebrates-his-century-during-day-four-of-the-picture-id1030463034?s=2048x2048',
                    //   fadeInCurve: Curves.easeInBack,
                    //   fit: BoxFit.cover,
                    // ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent
                          ])),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Welocome',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(color: Colors.white),
                            ),
                            Text(
                              'Joe',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        const ListTile(
                          minVerticalPadding: 0,
                          dense: true,
                          title: Text('Account'),
                        ),
                        const Divider(
                          height: 1,
                          color: Colors.black,
                        ),
                        ListTile(
                          onTap: () => {},
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const ChangeUserProfile())),
                          leading: const Icon(Icons.person_outline_outlined),
                          title: const Text('Change profile'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.visibility),
                          title: const Text('Change password'),
                        ),
                        ListTile(
                          onTap: () {},
                          leading: const Icon(Icons.logout_outlined),
                          title: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
