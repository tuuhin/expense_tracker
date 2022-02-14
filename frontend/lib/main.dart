import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/services/cubits/authCubit/auth_cubit.dart';
import 'package:expense_tracker/services/cubits/themeCubit/themecubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/utils/palette.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  // need to hide this from here
  await Hive.openBox('userdata');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
    ], child: const _App());
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit _theme = BlocProvider.of<ThemeCubit>(context, listen: true);

    return MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        themeMode: _theme.isDark ? ThemeMode.dark : ThemeMode.light,
        theme: Palette.lightTheme,
        darkTheme: Palette.darkTheme,
        home: const App());
  }
}
