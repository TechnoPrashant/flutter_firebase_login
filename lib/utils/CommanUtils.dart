import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:progress_hud/progress_hud.dart';

class CommanUtils {
  ProgressHUD progressHUD(String message) {
    ProgressHUD _progressHUD = new ProgressHUD(
      backgroundColor: Colors.transparent,
      color: Colors.white,
      containerColor: Colors.black,
      borderRadius: 5.0,
      text: message,
    );
    return _progressHUD;
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }

  bool validatePassword(String value) {
    if (value.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateName(String value) {
    if (value.length < 4) {
      return false;
    } else {
      return true;
    }
  }

  bool validateOTP(String value) {
    if (value.length != 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateMobile(String value) {
    String patttern = r'([+]?\d{1,2}[.-\s]?)?(\d{3}[.-]?){2}\d{4}';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return false;
    } else if (!regExp.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }

  void showToast(String message, BuildContext context) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }
}
