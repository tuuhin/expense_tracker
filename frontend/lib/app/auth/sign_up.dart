import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  final TabController controller;
  const SignUpPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _username;
  late TextEditingController _email;
  late TextEditingController _password;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(child: CustomPaint(painter: PaintSplashSignUp())),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 900),
            right: -20,
            top: 70,
            child: AnimatedOpacity(
                opacity: 1,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeInOut,
                child: Image.asset(
                  'assets/flaticons/app_flatline.png',
                  scale: 1.5,
                )),
          ),
          Positioned(
              left: 20,
              bottom: 340,
              child: Text(
                'Get Started',
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
                  obscureText: !isPasswordVisible,
                  obscuringCharacter: '*',
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    helperText: '',
                    hintText: 'Password',
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
                  style: ElevatedButton.styleFrom(
                      elevation: 8,
                      primary: Theme.of(context).colorScheme.secondary,
                      fixedSize: Size(_screenWidth, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  onPressed: () async {
                    //registration logic
                  },
                  child: Text('Register',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.white)),
                ),
                const Divider(),
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

class PaintSplashSignUp extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintOne = Paint()
      ..strokeWidth = 10
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;

    Path _pathOne = Path()
      ..moveTo(size.width * 0.6, 0)
      ..quadraticBezierTo(
          size.width * 0.4, size.height * 0.15, 0, size.height * 0.2)
      ..lineTo(0, 0);

    canvas.drawPath(_pathOne, paintOne);

    Paint paintTwo = Paint()
      ..strokeWidth = 10
      ..color = const Color(0xff7fc3dc)
      ..style = PaintingStyle.fill;
    Path _pathTwo = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * .75)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.9, size.width, size.height * 0.65)
      ..lineTo(size.width, size.height);
    canvas.drawPath(_pathTwo, paintTwo);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
