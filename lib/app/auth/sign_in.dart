import 'package:dio/dio.dart';
import 'package:expense_tracker/app/auth/auth.dart';
import 'package:expense_tracker/services/cubits/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  final TabController controller;
  const SignInPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
    final double _screenX = MediaQuery.of(context).size.width;
    final OutlinedBorder _shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(painter: PaintSplashSignIn()),
          ),
          Positioned(
            top: 110,
            right: -50,
            child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 500),
                child: Image.asset('assets/flaticons/flatline.png', scale: 1.5),
                builder: (context, value, child) => AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: value,
                    child: child)),
          ),
          Positioned(
              left: 10,
              bottom: 310,
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Welcome Back!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  builder: (context, value, child) {
                    return AnimatedPadding(
                      padding:
                          EdgeInsets.only(left: value * 10, top: value * 5),
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedOpacity(
                          opacity: value,
                          duration: const Duration(milliseconds: 500),
                          child: child),
                    );
                  })),
          Positioned(
              left: 20,
              bottom: 270,
              child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'Hey Dear user ,we think you are quite happy with \nour service,sign in to continue with your account',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  builder: (context, value, child) {
                    return AnimatedPadding(
                      padding: EdgeInsets.only(right: value * 10),
                      duration: const Duration(milliseconds: 500),
                      child: AnimatedOpacity(
                          opacity: value,
                          duration: const Duration(milliseconds: 500),
                          child: child),
                    );
                  })),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextField(
                  controller: _username,
                  keyboardType: TextInputType.text,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: const InputDecoration(
                      hintText: 'Username', prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _password,
                  obscureText: !_isPasswordVisible,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  decoration: InputDecoration(
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
                const SizedBox(height: 20),
                GestureDetector(
                    onTap: () =>
                        widget.controller.animateTo(2, curve: Curves.easeInOut),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have a account ',
                            style: Theme.of(context).textTheme.caption),
                        Text('Register',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
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
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenX, 50),
                      shape: _shape),
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
        ],
      ),
    );
  }
}
