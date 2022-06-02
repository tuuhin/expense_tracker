import 'package:dio/dio.dart' show Response;
import 'package:expense_tracker/app/widgets/widgets.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  final TabController controller;
  const SignInPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Duration _duration = const Duration(milliseconds: 500);
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  late AuthenticationCubit _auth;
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _auth = BlocProvider.of<AuthenticationCubit>(context);
  }

  Future<void> _signInUser(BuildContext context) async {
    if (_username.text.isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some the fields are blank')));
      return;
    } else {
      setState(() => _isLoading = !_isLoading);

      FocusScope.of(context).requestFocus(FocusNode());
      Response? _respn = await _auth.logUserIn(
          username: _username.text, password: _password.text);
      if (_respn!.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_respn.data['detail'].toString())));
        setState(() => _isLoading = !_isLoading);
        return;
      }
    }

    // _authProvider.changeAuthState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(painter: SignInSplash(context: context)),
          ),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              child: signInImage,
              builder: (context, double value, child) => AnimatedPositioned(
                    duration: _duration,
                    bottom: 40 + value * 20,
                    left: 15,
                    child: AnimatedOpacity(
                        duration: _duration, opacity: value, child: child),
                  )),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              child: Text('Welcome Back!',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      )),
              builder: (context, double value, child) => AnimatedPositioned(
                    left: 15,
                    top: 40 + value * 10,
                    duration: _duration,
                    child: AnimatedOpacity(
                        opacity: value, duration: _duration, child: child),
                  )),
          TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: _duration,
              child: SizedBox(
                  width: _size.width * .9,
                  child: Text(
                      'Hey Dear user ,we think you are quite happy with our service,sign in to continue with your account.',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 16,
                            color: Colors.white,
                          ))),
              builder: (context, double value, child) => AnimatedPositioned(
                    duration: _duration,
                    left: 15,
                    top: 90 + value * 10,
                    child: AnimatedOpacity(
                        opacity: value, duration: _duration, child: child),
                  )),
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: _duration,
            builder: (context, double value, child) => AnimatedPositioned(
              duration: _duration,
              left: 15,
              top: 170 + value * 10,
              child: AnimatedOpacity(
                  opacity: value, duration: _duration, child: child),
            ),
            child: SizedBox(
              height: _size.height * .25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: _size.width * .9,
                    child: TextField(
                      controller: _username,
                      keyboardType: TextInputType.text,
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.white70),
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person)),
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
                      cursorColor: Theme.of(context).colorScheme.secondary,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(color: Colors.white70),
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
          const SizedBox(height: 20),
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
                    widget.controller.animateTo(2, curve: Curves.easeInOut),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('Don\'t have an account? ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                          wordSpacing: 1)),
                  Text('SignIn',
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
                    fixedSize: Size(_size.width, 50),
                    primary: Theme.of(context).colorScheme.secondary),
                onPressed: () => _signInUser(context),
                child: !_isLoading
                    ? Text('Sign In',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white))
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
