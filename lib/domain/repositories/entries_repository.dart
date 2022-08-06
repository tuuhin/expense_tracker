import 'package:expense_tracker/domain/models/entries_information_model.dart';

abstract class EntriesRepository {
  Future<EntriesInfomationModel> getEntries();
  Future<EntriesInfomationModel> getMoreEntries(Map<String, dynamic> query);
}
