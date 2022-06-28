import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/data/local/user_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/utils/palette.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await UserData.init();

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // hold all the providers here
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider<IncomeSourceCubit>(
          create: (context) => IncomeSourceCubit(),
        ),
        BlocProvider<EntriesCubit>(
          create: (context) => EntriesCubit(),
        ),
        BlocProvider<ExpenseCategoriesCubit>(
          create: (context) => ExpenseCategoriesCubit(),
        ),
      ],
      child: const _App(),
    );
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit _theme = BlocProvider.of<ThemeCubit>(context);
    //entry point of the app
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: _theme.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      home: const App(),
    );
  }
}
