import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/model/UserBean.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

double imageHW = 100;

class Home extends StatelessWidget {
  UserBean _bean;

  Home(this._bean);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: HomeScreen(this._bean),
    );
  }
}

class HomeScreen extends StatefulWidget {
  UserBean _bean;

  HomeScreen(this._bean);

  @override
  _HomeScreenState createState() => _HomeScreenState(this._bean);
}

class _HomeScreenState extends State<HomeScreen> {
  UserBean _bean;

  _HomeScreenState(this._bean);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            showWidget(_bean),
            UtilsImporter().widgetUtils.spaceVertical(100),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(UtilsImporter().stringUtils.messageCong,
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: UtilsImporter().stringUtils.fontLogin,
                      fontSize: 30)),
            ),
            UtilsImporter().widgetUtils.spaceVertical(100),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text('Login Provider is  ' + _bean.loginProvide,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: UtilsImporter().stringUtils.fontLogin,
                      fontSize: 24)),
            )
          ],
        ),
      ),
    );
  }
}

Widget showWidget(UserBean _userbean) {
  if (_userbean.loginProvide == 'facebook' ||
      _userbean.loginProvide == 'google') {
    return FacebookOrGoogle(_userbean);
  } else if (_userbean.loginProvide == 'email') {
    return emailLogin(_userbean);
  } else {
    return mobileLogin(_userbean);
  }
}

Widget FacebookOrGoogle(UserBean _userbean) {
  return Container(
    child: Center(
      child: Column(
        children: <Widget>[
          Container(
            width: imageHW,
            height: imageHW,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(_userbean.profilPic),
                    fit: BoxFit.fill)),
          ),
          UtilsImporter().widgetUtils.spaceVertical(20),
          Text(_userbean.fullname,
              style: UtilsImporter().styleUtils.homeTextFieldStyle()),
          UtilsImporter().widgetUtils.spaceVertical(20),
          Text(_userbean.emailAddress,
              style: UtilsImporter().styleUtils.homeTextFieldStyle()),
        ],
      ),
    ),
  );
}

Widget emailLogin(UserBean _userbean) {
  return Container(
    height: double.maxFinite,
    margin: EdgeInsets.only(top: 100),
    child: Center(
      child: Column(
        children: <Widget>[
          Container(
            width: imageHW,
            height: imageHW,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(_userbean.profilPic),
                    fit: BoxFit.fill)),
          ),
          UtilsImporter().widgetUtils.spaceVertical(20),
          Text(_userbean.emailAddress,
              style: UtilsImporter().styleUtils.homeTextFieldStyle()),
        ],
      ),
    ),
  );
}

Widget mobileLogin(UserBean _userbean) {
  return Container(
    child: Center(
      child: Column(
        children: <Widget>[
          Container(
            width: imageHW,
            height: imageHW,
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(_userbean.profilPic),
                    fit: BoxFit.fill)),
          ),
          UtilsImporter().widgetUtils.spaceVertical(20),
          Text(_userbean.phoneNumber,
              style: UtilsImporter().styleUtils.homeTextFieldStyle()),
        ],
      ),
    ),
  );
}
