import 'package:expense_tracker/domain/models/entries_model.dart';

class EntriesInfomationModel {
  String? previousURL;
  String? nextURL;
  int highestCount;
  int overAllCount;

  List<EntriesModel> entries;
  EntriesInfomationModel({
    this.previousURL,
    this.nextURL,
    required this.highestCount,
    required this.overAllCount,
    required this.entries,
  });
}
