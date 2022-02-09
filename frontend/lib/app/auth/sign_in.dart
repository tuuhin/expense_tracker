import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Dio _dio = Dio();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                labelText: 'Email',
                helperText: 'Please enter a valid and registered email',
                prefixIcon: Icon(Icons.email)),
          ),
          TextField(
            controller: _password,
            obscureText: isPasswordVisible,
            obscuringCharacter: '*',
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              helperText: 'Enter your password',
              prefixIcon: const Icon(Icons.password),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() => isPasswordVisible = !isPasswordVisible);
                  },
                  icon: Icon(isPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility)),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              print(_email.text);
              // try {

              //  await  _dio
              //       .get('http://10.0.2.2:8000/api/income')
              //       .then((value) => print(value));

              // } catch (e) {
              //   print(e);
              // }
            },
            child: const Text('Fetch data'),
          )
        ],
      ),
    );
  }
}
