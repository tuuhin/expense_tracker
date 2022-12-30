import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/color_palettes.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import '../../context/context.dart';
import '../../domain/models/models.dart';

class SignUpPage extends StatefulWidget {
  final void Function() onTabChange;
  const SignUpPage({super.key, required this.onTabChange});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _email.dispose();
    _password.dispose();
  }

  bool _isPasswordVisible = false;

  Future _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    await context.read<AuthenticationCubit>().createUser(
          CreateUserModel(
            username: _username.text,
            password: _password.text,
            email: _email.text,
          ),
        );
  }

  final Duration _duration = const Duration(milliseconds: 300);

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
                painter: SignUpSplash(
              color: Theme.of(context).brightness == Brightness.light
                  ? SummerSplash.blueGreen
                  : MermaidLagoon.babyBlue,
              secondaryColor: Theme.of(context).brightness == Brightness.light
                  ? SummerSplash.blueGrotto
                  : MermaidLagoon.midnightBlue,
            )),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 1),
            duration: const Duration(milliseconds: 500),
            child: Image.asset('assets/flaticons/app_flatline.png'),
            builder: (context, value, child) => AnimatedPositioned(
              duration: _duration,
              top: 130 + value * 20,
              left: 20 + value * 10,
              child: AnimatedOpacity(
                duration: _duration,
                opacity: value,
                child: child,
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: kTextTabBarHeight),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Get Started',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          wordSpacing: 2,
                          letterSpacing: 1.2,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    builder: (context, value, child) => AnimatedOpacity(
                      opacity: value,
                      duration: _duration,
                      child: child,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TweenAnimationBuilder<double>(
                    builder: (context, value, child) => AnimatedOpacity(
                      opacity: value,
                      duration: _duration,
                      child: child,
                    ),
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: _duration,
                    child: Text(
                      'Let\'s begin our journey ,tracking your expenses really helps in maintianing your financial life',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) => value != null && value.isEmpty
                        ? "Blank username cannot be submitted"
                        : null,
                    controller: _username,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    validator: (value) => value != null && value.isEmpty
                        ? "Enter an email"
                        : value != null && validateEmail(value)
                            ? "Invalid Email"
                            : null,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StatefulBuilder(
                    builder: (context, changeState) => TextFormField(
                      validator: (value) => value != null && value.length < 5
                          ? "Minimum 5 characters required"
                          : null,
                      controller: _password,
                      obscureText: !_isPasswordVisible,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () => changeState(
                              () => _isPasswordVisible = !_isPasswordVisible),
                          icon: Icon(!_isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: widget.onTabChange,
              child: Text(
                'Already have an account? Sign In',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.1,
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            const Divider(height: 2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                backgroundColor: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(size.width, 50),
              ),
              onPressed: _registerUser,
              child: Text('Register',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white)),
            ),
          ],
        ),
      )),
    );
  }
}
