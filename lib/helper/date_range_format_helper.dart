import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangeHelper {
  static String format(DateTimeRange date) {
    final dateFormat = DateFormat("d-M-yyyy HH:MM");
    final date1 = dateFormat.format(date.start);
    final date2 = dateFormat.format(date.end);
    return date1 + " - " + date2;
  }
}
