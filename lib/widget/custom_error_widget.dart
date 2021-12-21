import 'package:flutter/material.dart';

enum Status { empty, error }

class CustomError extends StatelessWidget {
  const CustomError({Key? key, required this.errorStatus}) : super(key: key);

  final Status errorStatus;

  static Widget noDataMessage() {
    return const Center(child: Text('Tidak Ada Data'));
  }

  static Widget errorMessage() {
    return const Center(child: Text('Terjadi Error'));
  }

  @override
  Widget build(BuildContext context) {
    switch (errorStatus) {
      case Status.empty:
        return noDataMessage();
      case Status.error:
        return errorMessage();
      default:
        return Container();
    }
  }
}
