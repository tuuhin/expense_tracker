import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'context/context.dart';
import 'data/local/storage.dart';
import 'data/remote/remote.dart';
import 'data/repository/repository.dart';
import 'domain/repositories/repositories.dart';

class ProvidersWrapper extends StatelessWidget {
  final Widget child;
  const ProvidersWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ProfileRepository>(
            create: (context) => ProfileRepositoryImpl(
              api: UserDataApi(),
              profile: UserProfileDao(),
            ),
          ),
          RepositoryProvider<AuthRespository>(
            create: (context) => AuthRespositoryImpl(
              storage: SecureStorage(),
              auth: AuthApi(),
              profileData: context.read<ProfileRepository>(),
            ),
          ),
          RepositoryProvider<UserBaseDataRepository>(
            create: (context) => UserBaseDataRepoImpl(
              dao: UserBaseData(),
              api: BaseInfoApi(),
            ),
          ),
          RepositoryProvider<NotificationRepository>(
            create: (context) => NotificationRepoImpl(
              api: NotificationApi(),
            ),
          ),
          RepositoryProvider<EntriesRepository>(
            create: (context) => EntriesRepositoryImpl(
              api: EntriesApi(),
            ),
          ),
          RepositoryProvider<IncomeRepostiory>(
            create: (context) => IncomesRepoImpl(
              api: IncomeApi(),
              incomeStore: IncomeStorage(),
              sourceStore: IncomeSourceStorage(),
            ),
          ),
          RepositoryProvider<ExpenseRespository>(
            create: (context) => ExpenseRepoImpl(
              api: ExpensesApi(),
              expenseStore: ExpenseStorage(),
              categoryStore: CategoriesStorage(),
            ),
          ),
          RepositoryProvider<GoalsRepository>(
            create: (context) => GoalsRepositoryImpl(
              clt: GoalsClient(),
              dao: GoalsDao(),
            ),
          ),
          RepositoryProvider<BudgetRepository>(
            create: (context) => BudgetRepositoryImpl(
              api: BudgetApi(),
              cache: BudgetStorage(),
            ),
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
            BlocProvider<ProfileCubit>(
              create: (context) =>
                  ProfileCubit(context.read<ProfileRepository>()),
            ),
            BlocProvider<ThemeCubit>(
                create: (context) => ThemeCubit(ThemePreferences())),
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
                create: (context) => BaseInformationCubit(
                    context.read<UserBaseDataRepository>())),
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
