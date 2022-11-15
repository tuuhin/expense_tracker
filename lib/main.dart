import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';

import './context/context.dart';
import './data/local/local_storage.dart';
import './app/app.dart';
import './utils/palette.dart';
import './data/repository/user_profile_repo_impl.dart';
import './domain/repositories/user_profile_repository.dart';

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

  runApp(const ProvidersWrapper());
}

class ProvidersWrapper extends StatelessWidget {
  const ProvidersWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          // hold all the providers here
          BlocProvider<AuthenticationCubit>(
              create: (context) => AuthenticationCubit()),
          BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
          BlocProvider<IncomeSourceCubit>(
              create: (context) => IncomeSourceCubit()),
          BlocProvider<IncomeCubit>(create: (context) => IncomeCubit()),
          BlocProvider<ExpenseCubit>(create: (context) => ExpenseCubit()),
          BlocProvider<ExpenseCategoriesCubit>(
              create: (context) => ExpenseCategoriesCubit()),
          BlocProvider<BudgetCubit>(create: (context) => BudgetCubit()),
          BlocProvider<BaseInformationCubit>(
              create: (context) => BaseInformationCubit()),
          BlocProvider<EntriesCubit>(create: (context) => EntriesCubit()),
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserProfileRepository>(
                create: (context) => UserProfileRepositoryImpl())
          ],
          child: const MyApp(),
        ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        themeMode: context.watch<ThemeCubit>().themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const App(),
      );
}
