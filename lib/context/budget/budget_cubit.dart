import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:flutter/material.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit() : super(BudgetLoad());

  void getBudgetInfo(){
  }
}
