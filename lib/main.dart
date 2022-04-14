import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/domain/data/user_data.dart';
import 'package:expense_tracker/services/cubits/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/utils/palette.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await dotenv.load(fileName: '.env');
  await UserData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
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
    ], child: const _App());
  }
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeCubit _theme = BlocProvider.of<ThemeCubit>(context, listen: true);
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
