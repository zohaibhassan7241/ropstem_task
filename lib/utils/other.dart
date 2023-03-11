
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UtilOther {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors. black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }


  ///Singleton factory
  static final UtilOther _instance = UtilOther._internal();

  factory UtilOther() {
    return _instance;
  }

  UtilOther._internal();
}
