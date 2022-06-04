import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
  bool error = false,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: error ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}