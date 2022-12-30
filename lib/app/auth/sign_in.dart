import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../context/context.dart';
import '../../domain/models/models.dart';
import '../../utils/color_palettes.dart';
import '../widgets/splash/signin_painter.dart';

class SignInPage extends StatefulWidget {
  final void Function() onTabchange;

  const SignInPage({Key? key, required this.onTabchange}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _fromKey = GlobalKey<FormState>();

  late TextEditingController _username;
  late TextEditingController _password;

  bool _isPasswordVisible = false;

  Future<void> _signInUser() async {
    if (!_fromKey.currentState!.validate()) return;

    if (_username.text.isEmpty && _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Some the fields are blank')),
      );
      return;
    }

    await context.read<AuthenticationCubit>().logUserIn(
          LoginUserModel(
            username: _username.text,
            password: _password.text,
          ),
        );
  }

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  final Duration _duration = const Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: SignInSplash(
                color: Theme.of(context).brightness == Brightness.light
                    ? SummerSplash.blueGreen
                    : MermaidLagoon.babyBlue,
                secondaryColor: Theme.of(context).brightness == Brightness.light
                    ? SummerSplash.blueGrotto
                    : MermaidLagoon.midnightBlue,
              ),
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 60),
            duration: const Duration(milliseconds: 500),
            child: Image.asset('assets/flaticons/flatline.png'),
            builder: (context, double value, child) => AnimatedPositioned(
              duration: _duration,
              bottom: value,
              left: 15,
              child: AnimatedOpacity(
                  duration: _duration, opacity: value / 60, child: child),
            ),
          ),
          Form(
            key: _fromKey,
            child: Container(
              height: size.height,
              width: size.width,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kTextTabBarHeight),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                          color: Colors.white,
                          letterSpacing: 1.2),
                    ),
                    builder: (context, double value, child) => AnimatedOpacity(
                        opacity: value, duration: _duration, child: child),
                  ),
                  const SizedBox(height: 10),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: _duration,
                    child: Text(
                      'Hey Dear user ,we think you are quite happy with our service,sign in to continue with your account.',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white),
                    ),
                    builder: (context, double value, child) => AnimatedOpacity(
                        opacity: value, duration: _duration, child: child),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _username,
                    validator: (value) => value != null && value.isEmpty
                        ? "Fill the username"
                        : null,
                    keyboardType: TextInputType.text,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white70),
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, changeState) => TextFormField(
                      validator: (value) => value != null && value.isEmpty
                          ? "Fill the password"
                          : null,
                      controller: _password,
                      obscureText: !_isPasswordVisible,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white70),
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            color: Theme.of(context).colorScheme.secondary,
                            onPressed: () => changeState(
                                () => _isPasswordVisible = !_isPasswordVisible),
                            icon: Icon(!_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility)),
                      ),
                    ),
                  ),
                  const Spacer(flex: 5)
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: widget.onTabchange,
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.1,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ),
              const Divider(height: 2),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(size.width, 50),
                    backgroundColor: Theme.of(context).colorScheme.secondary),
                onPressed: _signInUser,
                child: Text(
                  'Sign In',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
