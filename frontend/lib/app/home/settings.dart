import 'package:expense_tracker/app/home/routes/bottomsheet/add_source.dart';
import 'package:expense_tracker/app/home/routes/routes.dart';
import 'package:expense_tracker/services/cubits/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vector_math/vector_math.dart' show radians;

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  void alertLogout(BuildContext context) async {
    final AuthenticationCubit _auth =
        BlocProvider.of<AuthenticationCubit>(context);
    return await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('Logout'),
              content: const Text('Are you sure you want to log out?'),
              actions: [
                TextButton(
                  onPressed: () {
                    _auth.logOut();
                    Navigator.of(context).pop();
                  },
                  child: Text('Logout',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.error)),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final ThemeCubit _theme =
        BlocProvider.of<ThemeCubit>(context, listen: true);
    return Container(
      width: _size.width,
      height: _size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary,
            Theme.of(context).scaffoldBackgroundColor,
          ])),
      child: Row(
        children: [
          SizedBox(
            width: _size.width * .65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text('Welcome',
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  dense: true,
                  onTap: () => Navigator.of(context)
                      .push(customPageRoute(const AddIncome())),
                  title: const Text('Add Income'),
                  leading:
                      const FaIcon(FontAwesomeIcons.moneyBillWave, size: 15),
                ),
                ListTile(
                  dense: true,
                  onTap: () => Navigator.of(context)
                      .push(customPageRoute(const AddExpenses())),
                  title: const Text('Add Expense'),
                  leading: const FaIcon(FontAwesomeIcons.moneyCheck, size: 15),
                ),
                const Divider(),
                ListTile(
                    dense: true,
                    onTap: () =>
                        showBottomSheetRoute(context, const AddSource()),
                    title: const Text('Add Source'),
                    leading:
                        const FaIcon(FontAwesomeIcons.productHunt, size: 15)),
                ListTile(
                    dense: true,
                    onTap: () =>
                        showBottomSheetRoute(context, const AddCategories()),
                    title: const Text('Add Categories'),
                    leading:
                        const FaIcon(FontAwesomeIcons.buyNLarge, size: 15)),
                const Divider(),
                ListTile(
                  dense: true,
                  trailing: Switch(
                    value: _theme.isDark,
                    onChanged: (bool newValue) {
                      _theme.changeTheme();
                    },
                  ),
                  title: const Text('Toggle Theme'),
                ),
                ListTile(
                  iconColor: Colors.pinkAccent,
                  textColor: Colors.pinkAccent,
                  onTap: () => alertLogout(context),
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Route customPageRoute(Widget widget) => PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 700),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Animation<double> _rotation = Tween<double>(begin: 90, end: 0)
          .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
      return Transform(
          transform: Matrix4.identity()..rotateY(radians(-1 * _rotation.value)),
          child: child);
    });

void showBottomSheetRoute(BuildContext context, Widget widget) =>
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: widget,
            ));
