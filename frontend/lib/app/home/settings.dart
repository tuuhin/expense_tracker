import 'package:expense_tracker/app/home/routes/add_income.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:expense_tracker/services/cubits/themeCubit/themecubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  void alertLogout(BuildContext context) async {
    final AuthCubit _authCubit = BlocProvider.of<AuthCubit>(context);
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: const Text('Logout'),
              content: const Text('Are you sure you want to log out '),
              actions: [
                TextButton(
                    onPressed: () {
                      _authCubit.removeAuthState();
                      Navigator.of(context).pop();
                    },
                    child: Text('Logout',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final double _screenX = MediaQuery.of(context).size.width;
    final double _screenY = MediaQuery.of(context).size.height;
    final ThemeCubit _theme =
        BlocProvider.of<ThemeCubit>(context, listen: true);
    return Container(
      width: _screenX,
      height: _screenY,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
            Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            Theme.of(context).scaffoldBackgroundColor,
          ])),
      child: Row(
        children: [
          SizedBox(
            width: _screenX * .7,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ListTile(
                    title: Text('Add'),
                  ),
                  ListTile(
                    dense: true,
                    onTap: () {
                      Navigator.of(context).push(_addIncomeRoute());
                    },
                    title: const Text('Add Income'),
                    leading: const Icon(Icons.add),
                  ),
                  ListTile(
                    dense: true,
                    onTap: () {},
                    title: const Text('Add Expense'),
                    leading: const Icon(Icons.add),
                  ),
                  const Divider(),
                  ListTile(
                    dense: true,
                    trailing: Switch(
                      value: _theme.isDark,
                      onChanged: (bool newValue) {
                        _theme.changeTheme();
                      },
                    ),
                    leading: Icon(
                        Theme.of(context).brightness == Brightness.light
                            ? Icons.dark_mode
                            : Icons.light),
                    title: const Text('Toggle Theme'),
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: () => alertLogout(context),
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Route _addIncomeRoute() => PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 800),
    pageBuilder: (context, animation, secondaryAnimation) => const AddIncome(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Animation<double> rotation =
          Tween<double>(begin: 270, end: 360).animate(animation);

      return Transform(
          transform: Matrix4.identity()
            // ..scale(animation.value)
            ..rotateY(-1 * radians(rotation.value)),
          child: FadeTransition(opacity: animation, child: child));
    });
