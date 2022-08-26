import 'package:intl/intl.dart';

String toDate(DateTime dateTime) => DateFormat("yMMMMEEEEd").format(dateTime);

String toSimpleDate(DateTime dateTime) => DateFormat("yMMMMd").format(dateTime);

String toServerFormat(DateTime dateTime) =>
    DateFormat("yyyy-MM-DD").format(dateTime);
