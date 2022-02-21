import 'package:dio/dio.dart';
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
    if (!_isLoading) {
      setState(() => _isLoading = !_isLoading);
    }
    if (_username.text.isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some the fields are blank')));
    } else {
      setState(() => _isLoading = !_isLoading);
      Response? _respn = await _auth.logUserIn(
          username: _username.text, password: _password.text);

      if (_respn!.statusCode != 200) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_respn.data['detail'].toString())));
        setState(() => _isLoading = !_isLoading);
      }
    }

    // _authProvider.changeAuthState();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CustomPaint(painter: PaintSplashSignIn())),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            top: 110,
            right: -50,
            child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/flaticons/flatline.png',
                  scale: 1.5,
                )),
          ),
          Positioned(
              left: 20,
              bottom: 280,
              child: Text(
                'Welcome Back!',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 28),
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
                      hintText: 'Username', prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _password,
                  obscureText: !_isPasswordVisible,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenWidth, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () => _signInUser(context),
                  child: !_isLoading
                      ? Text('Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Colors.white))
                      : const CircularProgressIndicator(),
                ),
                const Divider(),
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
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary))
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaintSplashSignIn extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    Path _pathOne = Path()
      ..moveTo(size.width, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..cubicTo(size.width * 0.65, size.height * 0.2, size.width * 0.45,
          size.height * 0.6, 0, size.height * 0.5)
      ..lineTo(0, 0);

    canvas.drawPath(_pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = const Color(0xff7fc3dc)
      ..style = PaintingStyle.fill;
    Path _pathTwo = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.9)
      ..cubicTo(size.width * 0.4, size.height * 0.9, size.width * .7,
          size.height * 0.7, size.width, size.height * .75)
      ..lineTo(size.width, size.height);
    canvas.drawPath(_pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
