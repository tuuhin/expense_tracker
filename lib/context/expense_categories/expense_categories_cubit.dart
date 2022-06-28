import 'package:bloc/bloc.dart';
import 'package:expense_tracker/data/remote/expenses_client.dart';
import 'package:expense_tracker/domain/models/expense_categories_model.dart';

import 'package:meta/meta.dart';

part 'expense_categories_state.dart';

class ExpenseCategoriesCubit extends Cubit<ExpenseCategoriesState> {
  ExpenseCategoriesCubit() : super(ExpenseCategoriesLoad());
  final ExpensesClient _clt = ExpensesClient();
  List<int> _selecedCategories = [];

  List<int> get sources => _selecedCategories;

  void addToSelected(int id) {
    if (!_selecedCategories.contains(id)) {
      _selecedCategories.add(id);
    }
  }

  void removeFromSelected(int id) {
    if (_selecedCategories.contains(id)) {
      _selecedCategories.remove(id);
    }
  }

  void refreshCategories() {
    _selecedCategories = [];
    emit(ExpenseCategoriesLoad());
  }

  void getCategories() async {
    List? _data = await _clt.getCategories();
    if (_data != null) {
      List<ExpenseCategoriesModel> models =
          _data.map((e) => ExpenseCategoriesModel.fromJson(e)).toList();
      emit(ExpenseCategoriesLoadSuccess(models: models));
    } else {
      emit(ExpenseCategoriesLoadFailed());
    }
  }
}
