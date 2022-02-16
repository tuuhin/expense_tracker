import 'package:bloc/bloc.dart';
import 'package:expense_tracker/domain/models/income_sources/income_source_model.dart';
import 'package:expense_tracker/services/api/income_client.dart';
import 'package:meta/meta.dart';

part 'income_source_state.dart';

class IncomeSourceCubit extends Cubit<IncomeSourceState> {
  IncomeSourceCubit() : super(IncomeSourceLoad());
  final IncomeClient _clt = IncomeClient();

  void refreshSources() {
    emit(IncomeSourceLoad());
  }

  void loadData() async {
    List? _data = await _clt.getIncomeSources();
    if (_data != null) {
      List<IncomeSourceModel> models = _data
          .map((e) => IncomeSourceModel(
              id: e['id'],
              title: e['title'],
              desc: e['desc'],
              isSecure: e['is_secure']))
          .toList();
      emit(IncomeSourceLoaded(models: models));
    } else {
      emit(IncomeSourceLoadFailed());
    }
  }
}
