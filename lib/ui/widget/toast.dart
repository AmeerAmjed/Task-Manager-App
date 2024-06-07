import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_manager/ui/utils/dimens.dart';

toast(
  String message, {
  Color? backgroundColor,
  Color? textColor,
}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: backgroundColor ?? Colors.black,
    textColor: textColor ?? Colors.white,
    fontSize: Dimens.fontSize16,
  );
}
