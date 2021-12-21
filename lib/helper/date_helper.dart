import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String formatDateTime(Timestamp value) {
    final dateFormat = DateFormat("EEE, d-M HH:MM");
    final date =
        DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch);
    return dateFormat.format(date);
  }

  static String formatDateRange(DateTimeRange date) {
    final dateFormat = DateFormat("d-M-yyyy HH:MM");
    final date1 = dateFormat.format(date.start);
    final date2 = dateFormat.format(date.end);
    return date1 + " - " + date2;
  }

  static String timeStatus(String date) {
    final firstDate = DateTime.parse(date.split(' - ').first);
    final lastDate = DateTime.parse(date.split(' - ').last);
    if (lastDate.compareTo(DateTime.now()) < 0) {
      return 'Selesai';
    } else if (firstDate.compareTo(DateTime.now()) < 0 &&
        lastDate.compareTo(DateTime.now()) > 0) {
      return 'Sedang di Pesan';
    } else {
      return 'Dalam Pemesanan';
    }
  }
}
