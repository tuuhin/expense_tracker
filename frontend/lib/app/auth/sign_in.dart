import 'package:expense_tracker/services/api/api_auth.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final ApiAuth _auth = ApiAuth();

  Widget showErrorDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Invalid Credentials'),
      content: const Text('please put valid credentials'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Continue'),
        )
      ],
    );
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    AuthCubit _authProvider = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: CustomPaint(
              painter: PaintScr(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _username,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person)),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _password,
                  obscureText: !isPasswordVisible,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                        onPressed: () => setState(
                            () => isPasswordVisible = !isPasswordVisible),
                        icon: Icon(!isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_username.text.isEmpty || _password.text.isEmpty) {
                      return showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              showErrorDialog(context));
                    }
                    _authProvider.openLoader();
                    bool value = await _auth.logUserIn(
                        username: _username.text, password: _password.text);
                    if (value) {
                      _authProvider.login();
                    } else {
                      _authProvider.failedLogin();
                    }
                  },
                  child: const Text('Fetch data'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaintScr extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 10
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    Path _path = Path();
    _path.moveTo(0, size.height);
    _path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.75, size.width, size.height * 0.8);
    _path.lineTo(size.width, size.height);
    canvas.drawPath(_path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
