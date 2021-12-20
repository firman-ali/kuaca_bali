import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String format(Timestamp value) {
    final dateFormat = DateFormat("EEE, d-M HH:MM");
    final date =
        DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch);
    return dateFormat.format(date);
  }
}
