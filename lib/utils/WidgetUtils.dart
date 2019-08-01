import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

class WidgetUtils {
  Widget button(String buttonName) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: Colors.black,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: UtilsImporter().stringUtils.fontRoboto),
            ),
          )),
    );
  }

  Widget buttonVerification(String buttonName, Color color) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      color: color,
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Center(
            child: Text(
              buttonName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: UtilsImporter().stringUtils.fontRoboto),
            ),
          )),
    );
  }

  Widget socialButton(String imageName) {
    return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(80))),
        child: Image.asset(
          imageName,
          height: 48,
          width: 48,
        ));
  }

  Widget spaceVertical(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget spacehorizontal(double width) {
    return SizedBox(
      width: width,
    );
  }
}
