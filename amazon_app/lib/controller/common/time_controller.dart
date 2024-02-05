import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// Format DateTime data to String data.
String formatDateTime(DateTime datetime) {
  final formatter = DateFormat('yyyy/MM/dd HH');
  return formatter.format(datetime);
}

/// Format String data to DateTime data.
DateTime formatString(String datetime) {
  return DateFormat('yyyy/MM/dd HH').parseStrict(datetime);
}

/// Format DateTime data to String data. And Except year data.
String formatDateTimeExcYear(DateTime datetime) {
  final formatter = DateFormat('MM/dd HH:mm');
  return formatter.format(datetime);
}

/// Format DateTime data to String data. And Except year data.
DateTime formatStringExcYear(String datetime) {
  return DateFormat('MM/dd HH:mm').parseStrict(datetime);
}

/// Convert Timestamp to DateTime.
DateTime? convertTimestampToDateTime(dynamic timestamp) {
  return timestamp is Timestamp ? timestamp.toDate() : null;
}
