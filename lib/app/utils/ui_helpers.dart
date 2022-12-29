double ratioFromDateTime(DateTime start, DateTime end) {
  /// Math.round(((today - start) / (end - start)) * 100) + '%';

  double percentage = (DateTime.now().difference(start).inMinutes) /
      (end.difference(start).inMinutes);

  return percentage <= 1 ? percentage : 1;
}
