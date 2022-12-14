import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'context/context.dart';
import 'context/goals/goals_bloc.dart';
import 'data/local/goals_dao.dart';
import 'data/local/storage.dart';
import 'data/remote/auth_api.dart';
import 'data/remote/budget_api.dart';
import 'data/remote/entries_api.dart';
import 'data/remote/goals_client.dart';
import 'data/remote/remote.dart';
import 'data/repository/budget_repository_impl.dart';
import 'data/repository/expense_repo_impl.dart';
import 'data/repository/goals_repo_impl.dart';
import 'data/repository/income_repo_impl.dart';
import 'data/repository/repository.dart';
import 'domain/repositories/goals_repository.dart';
import 'domain/repositories/repositories.dart';

class ProvidersWrapper extends StatelessWidget {
  final Widget child;
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UserProfileRepository>(
            create: (context) => UserProfileRepositoryImpl(),
          ),
          RepositoryProvider<AuthRespository>(
            create: (context) => AuthRespositoryImpl(
              storage: SecureStorage(),
              auth: AuthApi(),
              profileData: context.read<UserProfileRepository>(),
            ),
          ),
          RepositoryProvider<NotificationRepository>(
            create: (context) => NotificationRepoImpl(),
          ),
          RepositoryProvider<EntriesRepository>(
            create: (context) => EntriesRepositoryImpl(api: EntriesApi()),
          ),
          RepositoryProvider<IncomeRepostiory>(
            create: (context) => IncomesRepoImpl(
                api: IncomeApi(),
                incomeStore: IncomeStorage(),
                sourceStore: IncomeSourceStorage()),
          ),
          RepositoryProvider<ExpenseRespository>(
            create: (context) => ExpenseRepoImpl(
                api: ExpensesApi(),
                expenseStore: ExpenseStorage(),
                categoryStore: CategoriesStorage()),
          ),
          RepositoryProvider<GoalsRepository>(
            create: (context) =>
                GoalsRepositoryImpl(clt: GoalsClient(), dao: GoalsDao()),
          ),
          RepositoryProvider<BudgetRepository>(
            create: (context) =>
                BudgetRepositoryImpl(api: BudgetApi(), cache: BudgetStorage()),
          )
        ],
        child: MultiBlocProvider(
          providers: [
            // hold all the providers here
            BlocProvider<AuthenticationCubit>(
              create: (context) =>
                  AuthenticationCubit(context.read<AuthRespository>())
                    ..checkAuthState(),
            ),
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(),
            ),
            BlocProvider<IncomeSourceCubit>(
                create: (context) =>
                    IncomeSourceCubit(context.read<IncomeRepostiory>())),
            BlocProvider<IncomeCubit>(
                create: (context) =>
                    IncomeCubit(context.read<IncomeRepostiory>())),
            BlocProvider<ExpenseCubit>(
                create: (context) =>
                    ExpenseCubit(context.read<ExpenseRespository>())),
            BlocProvider<ExpenseCategoriesCubit>(
                create: (context) =>
                    ExpenseCategoriesCubit(context.read<ExpenseRespository>())),
            BlocProvider<BudgetCubit>(
                create: (context) =>
                    BudgetCubit(context.read<BudgetRepository>())),
            BlocProvider<BaseInformationCubit>(
                create: (context) => BaseInformationCubit()),
            BlocProvider<GoalsBloc>(
                create: (context) =>
                    GoalsBloc(context.read<GoalsRepository>())),
            BlocProvider<EntriesBloc>(
                create: (context) =>
                    EntriesBloc(context.read<EntriesRepository>())),
            BlocProvider<NotificationBloc>(
                create: (context) =>
                    NotificationBloc(context.read<NotificationRepository>()))
          ],
          child: child,
        ),
      );
}
