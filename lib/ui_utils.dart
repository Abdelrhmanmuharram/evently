import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static void showSuccessMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: Colors.green,
    textColor: AppTheme.white,
  );static void showErrorMessage([String? message]) => Fluttertoast.showToast(
    msg: message ?? 'Something went wrong, please try again later.',
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: AppTheme.red,
    textColor: AppTheme.white,
  );
}
