import 'package:dio/dio.dart';
import 'package:expense_tracker/app/auth/auth.dart';
import 'package:expense_tracker/services/cubits/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _auth = BlocProvider.of<AuthenticationCubit>(context);
  }

  Widget _animatedHeading(BuildContext context, double value, Widget? child) {
    return AnimatedPadding(
      padding: EdgeInsets.only(left: value * 10, top: value * 5),
      duration: const Duration(milliseconds: 500),
      child: AnimatedOpacity(
          opacity: value,
          duration: const Duration(milliseconds: 500),
          child: child),
    );
  }

  Future<void> registerUser(BuildContext context) async {
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
    final double _screenX = MediaQuery.of(context).size.width;
    final OutlinedBorder _shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(painter: PaintSplashSignUp()),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            right: -20,
            top: 70,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                child: Image.asset('assets/flaticons/app_flatline.png',
                    scale: 1.5),
                builder: (context, value, child) => AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value,
                    child: child)),
          ),
          Positioned(
              left: 10,
              bottom: 370,
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Get Started',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  builder: _animatedHeading)),
          Positioned(
              left: 10,
              bottom: 340,
              child: TweenAnimationBuilder<double>(
                builder: _animatedHeading,
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                child: Text(
                    'Let\'s begin our journey ,tracking your expenses really\nhelps in maintianing your financial life',
                    style: Theme.of(context).textTheme.caption),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextField(
                  controller: _username,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
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
                GestureDetector(
                    onTap: () =>
                        widget.controller.animateTo(1, curve: Curves.easeInOut),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already  have a account ',
                            style: Theme.of(context).textTheme.caption),
                        Text('SignIn',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))
                      ],
                    )),
                const Divider(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: _shape),
                  onPressed: () => registerUser(context),
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
          ),
        ],
      ),
    );
  }
}
