import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'context/context.dart';
import 'data/remote/remote.dart';
import 'data/repository/repository.dart';
import 'domain/repositories/repositories.dart';

class ProvidersWrapper extends StatelessWidget {
  final Widget child;
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          // hold all the reposioty here
          RepositoryProvider<UserProfileRepository>(
              create: (context) => UserProfileRepositoryImpl()),
          RepositoryProvider<NotificationRepository>(
              create: (context) => NotificationRepoImpl()),
          RepositoryProvider<EntriesRepository>(
              create: (context) => EntriesRepositoryImpl()),
          RepositoryProvider<ExpenseRepostiory>(
              create: (context) => ExpensesApi())
        ],
        child: MultiBlocProvider(
          providers: [
            // hold all the providers here
            BlocProvider<AuthenticationCubit>(
                create: (context) => AuthenticationCubit(context)),
            BlocProvider<ThemeCubit>(create: (context) => ThemeCubit()),
            BlocProvider<IncomeSourceCubit>(
                create: (context) => IncomeSourceCubit()),
            BlocProvider<IncomeCubit>(create: (context) => IncomeCubit()),
            BlocProvider<ExpenseCubit>(
                create: (context) =>
                    ExpenseCubit(context.read<ExpenseRepostiory>())),
            BlocProvider<ExpenseCategoriesCubit>(
                create: (context) =>
                    ExpenseCategoriesCubit(context.read<ExpenseRepostiory>())),
            BlocProvider<BudgetCubit>(create: (context) => BudgetCubit()),
            BlocProvider<BaseInformationCubit>(
                create: (context) => BaseInformationCubit()),
            BlocProvider<EntriesBloc>(
                create: (context) =>
                    EntriesBloc(context.read<EntriesRepository>())),
            BlocProvider<NotificationBloc>(
                create: (context) =>
                    NotificationBloc(context.read<NotificationRepository>())
                      ..init())
          ],
          child: child,
        ),
      );
}
