import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

import './context/context.dart';
import './data/local/local_storage.dart';
import './utils/palette.dart';

import 'providers.dart';
import 'router.dart';

final logger = Logger('App Logger');

void main() async {
  // Logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) => debugPrint(
      '${record.loggerName} ${record.level.name}: ${record.time}: ${record.message}'));

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  await LocalStorage().init();

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  runApp(const ProvidersWrapper(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        themeMode: context.watch<ThemeCubit>().themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      );
}
