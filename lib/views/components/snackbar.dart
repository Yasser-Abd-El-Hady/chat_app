import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
    BuildContext context, Widget widget) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: widget));
}
