import 'package:dio/dio.dart' show Response;
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  final TabController controller;
  const SignUpPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  late AuthenticationCubit _auth;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _auth = BlocProvider.of<AuthenticationCubit>(context);
  }

  Future<void> registerUser() async {
    if (_username.text.isEmpty ||
        _email.text.isEmpty ||
        _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some the fields are blank')));
    } else if (_username.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username field is blank')));
    } else if (_email.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Email field is blank')));
    } else if (!RegExp(r'\b[a-zA-Z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(_email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please give a propper email')));
    } else if (_password.text.length <= 5) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password is too small')));
    } else {
      setState(() => _isLoading = !_isLoading);
      FocusScope.of(context).requestFocus(FocusNode());
      Response? _response = await _auth.createUser(
          username: _username.text,
          password: _password.text,
          email: _email.text);

      if (_response!.statusCode != 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(_response.toString())));
        setState(() => _isLoading = !_isLoading);
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(painter: SignUpSplash(context: context)),
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              child: signUpImage,
              builder: (context, value, child) => AnimatedPositioned(
                    duration: _duration,
                    top: 130 + value * 20,
                    left: 20 + value * 10,
                    child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 400),
                        opacity: value,
                        child: child),
                  )),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            child: Text('Get Started',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 2,
                      letterSpacing: 1.2,
                    )),
            builder: (context, double value, child) => AnimatedPositioned(
                left: 15,
                top: 40 + value * 10,
                child: AnimatedOpacity(
                  child: child,
                  opacity: value,
                  duration: _duration,
                ),
                duration: _duration),
          ),
          TweenAnimationBuilder<double>(
            builder: (context, double value, child) => AnimatedPositioned(
                left: 15,
                top: 90 + value * 10,
                child: AnimatedOpacity(
                  child: child,
                  opacity: value,
                  duration: _duration,
                ),
                duration: _duration),
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 600),
            child: SizedBox(
                width: _size.width * .9,
                child: Text(
                    'Let\'s begin our journey ,tracking your expenses really helps in maintianing your financial life',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16,
                        fontFamily: GoogleFonts.poppins().fontFamily))),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: _duration,
            builder: (context, double value, child) => AnimatedPositioned(
                left: 15,
                top: 170 + value * 10,
                child: AnimatedOpacity(
                  opacity: value,
                  duration: _duration,
                  child: child,
                ),
                duration: _duration),
            child: SizedBox(
              height: _size.height * .35,
              child: Column(
                children: [
                  SizedBox(
                    width: _size.width * .9,
                    child: TextField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: _size.width * .9,
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: _size.width * .9,
                    child: TextField(
                      controller: _password,
                      obscureText: !_isPasswordVisible,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        helperText: '',
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.password),
                        suffixIcon: IconButton(
                            onPressed: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible),
                            icon: Icon(!_isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility)),
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
            GestureDetector(
              onTap: () =>
                  widget.controller.animateTo(1, curve: Curves.easeInOut),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Already have an account? ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        wordSpacing: 1)),
                Text('SignUp',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                        decoration: TextDecoration.underline,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.1,
                        color: Theme.of(context).colorScheme.secondary))
              ]),
            ),
            const Divider(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 8,
                primary: Theme.of(context).colorScheme.secondary,
                fixedSize: Size(_size.width, 50),
              ),
              onPressed: registerUser,
              child: !_isLoading
                  ? Text('Register',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: Colors.white))
                  : const CircularProgressIndicator(),
            ),
          ],
        ),
      )),
    );
  }
}
