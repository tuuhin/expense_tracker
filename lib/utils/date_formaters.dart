import 'package:intl/intl.dart';

String toDate(DateTime dateTime) => DateFormat("yMMMMEEEEd").format(dateTime);
