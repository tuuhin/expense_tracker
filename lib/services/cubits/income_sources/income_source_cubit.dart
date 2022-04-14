import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/models/income_sources/income_source_model.dart';
import 'package:expense_tracker/services/api/income_client.dart';
import 'package:meta/meta.dart';

part 'income_source_state.dart';

class IncomeSourceCubit extends Cubit<IncomeSourceState> {
  IncomeSourceCubit() : super(IncomeSourceLoad());
  final IncomeClient _clt = IncomeClient();
  List<int> _selecedSources = [];

  List<int> get sources => _selecedSources;

  void addToSelected(int id) {
    if (!_selecedSources.contains(id)) {
      _selecedSources.add(id);
    }
  }

  void removeFromSelected(int id) {
    if (_selecedSources.contains(id)) {
      _selecedSources.remove(id);
    }
  }

  void refreshSources() {
    _selecedSources = [];
    emit(IncomeSourceLoad());
  }

  void loadData() async {
    List? _data = await _clt.getIncomeSources();
    if (_data != null) {
      List<IncomeSourceModel> models =
          _data.map((e) => IncomeSourceModel.fromJson(e)).toList();
      emit(IncomeSourceLoaded(models: models));
    } else {
      emit(IncomeSourceLoadFailed());
    }
  }
}
