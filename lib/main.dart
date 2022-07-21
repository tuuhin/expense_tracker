import 'package:expense_tracker/app/app.dart';
import 'package:expense_tracker/context/context.dart';
import 'package:expense_tracker/context/user_info/user_info_cubit.dart';
import 'package:expense_tracker/data/local/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/utils/palette.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

final logger = Logger('App Logger');

void main() async {
  // Logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await LocalStorage.init();

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const ProvidersWrapper());
}

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({Key? key}) : super(key: key);

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
        BlocProvider<IncomeCubit>(
          create: (context) => IncomeCubit(),
        ),
        BlocProvider<EntriesCubit>(
          create: (context) => EntriesCubit(),
        ),
        BlocProvider<ExpenseCubit>(
          create: (context) => ExpenseCubit(),
        ),
        BlocProvider<ExpenseCategoriesCubit>(
          create: (context) => ExpenseCategoriesCubit(),
        ),
        BlocProvider<UserInfoCubit>(
          create: (context) => UserInfoCubit(),
        )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeCubit>().themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const App(),
    );
  }
}
