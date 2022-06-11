import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFailed extends StatefulWidget {
  final String? details;
  final String? code;
  const AuthFailed({
    Key? key,
    this.details,
    this.code,
  }) : super(key: key);

  @override
  State<AuthFailed> createState() => _AuthFailedState();
}

class _AuthFailedState extends State<AuthFailed> {
  late AuthenticationCubit _auth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _auth = BlocProvider.of<AuthenticationCubit>(context);
  }

  void returnToMenu() => _auth.logOut();

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: _size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            authFailed(),
            const SizedBox(height: 20),
            Text('Authentication failed',
                style: Theme.of(context).textTheme.subtitle1),
            Text(widget.code ?? '',
                style: Theme.of(context).textTheme.subtitle1)
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Divider(height: 2),
            TextButton(
                style: TextButton.styleFrom(
                  fixedSize: Size(_size.width, 50),
                ),
                onPressed: returnToMenu,
                child: Text('Return to the menu',
                    style: Theme.of(context).textTheme.subtitle1!)),
          ],
        ),
      )),
    );
  }
}
