import 'package:date_time_format/date_time_format.dart';

String toDate(DateTime dateTime) =>
    DateTimeFormat.format(dateTime, format: DateTimeFormats.americanAbbr);
