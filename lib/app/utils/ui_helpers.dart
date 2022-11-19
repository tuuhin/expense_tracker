import 'package:expense_tracker/utils/date_formaters.dart';

double ratioFromDateTime(DateTime from, DateTime to) {
  int fromEpoch = from.millisecondsSinceEpoch;
  int toEpoch = to.millisecondsSinceEpoch;

  return ((toEpoch - fromEpoch) / fromEpoch * 100);
}
