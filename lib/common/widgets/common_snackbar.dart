import 'package:flutter/material.dart';

void showsnackbar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
    ),
  );
}