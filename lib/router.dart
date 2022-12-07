import 'package:expense_tracker/app/app.dart';
import 'package:go_router/go_router.dart';

import '../domain/models/models.dart';
import '../app/home/routes/routes.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const App()),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const UserOptionsRoute(),
    ),
    GoRoute(
      path: '/income',
      builder: (context, state) => const ShowIncomes(),
    ),
    GoRoute(
      path: '/create-income',
      builder: (context, state) => CreateIncome(),
    ),
    GoRoute(
      path: '/update-income',
      builder: (context, state) =>
          CreateIncome(isUpdate: true, income: state.extra as IncomeModel),
    ),
    GoRoute(
      path: '/sources',
      builder: (context, state) => const ShowIncomeSources(),
    ),
    GoRoute(
      path: '/expenes',
      builder: (context, state) => const ShowExpenses(),
    ),
    GoRoute(
      path: '/create-expense',
      builder: (context, state) => CreateExpense(),
    ),
    GoRoute(
      path: '/update-expense',
      builder: (context, state) =>
          CreateExpense(expense: state.extra as ExpenseModel, isUpdate: true),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const ShowExpenseCategories(),
    ),
    GoRoute(
      path: '/budgets',
      builder: (context, state) => const ShowBudget(),
    ),
    GoRoute(
      path: '/create-budget',
      builder: (context, state) => const CreateBudget(),
    ),
    GoRoute(
      path: '/update-budget',
      builder: (context, state) =>
          CreateBudget(budget: state.extra as BudgetModel, isUpdate: true),
    ),
    GoRoute(
      path: '/goals',
      builder: (context, state) => const ShowGoals(),
    ),
    GoRoute(
      path: '/create-goals',
      builder: (context, state) => const CreateGoals(),
    ),
    GoRoute(
      path: '/update-goals',
      builder: (context, state) =>
          CreateGoals(isUpdate: true, goal: state.extra as GoalsModel),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => const ChangePasswordRoute(),
    ),
    GoRoute(
      path: '/change-profile',
      builder: (context, state) => const ChangeUserProfile(),
    )
  ],
);
