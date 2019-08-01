import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/model/UserBean.dart';
import 'package:flutter_firebase_login/screens/Home.dart';
import 'package:flutter_firebase_login/screens/Login.dart';
import 'package:flutter_firebase_login/screens/LoginWithMobileNumber.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

class CreateAccount extends StatelessWidget {
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
      body: CreateAccountScreen(),
    );
  }
}

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  double cardElevation = 8;
  TextEditingController _textEditingControllerName =
      new TextEditingController();
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerPassword =
      new TextEditingController();
  TextEditingController _textEditingControllerMobile =
      new TextEditingController();
  bool isLoginSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(UtilsImporter().stringUtils.lableCreateAccount,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: UtilsImporter().stringUtils.fontLogin,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                      shadows: UtilsImporter().styleUtils.textShadow())),
              UtilsImporter().widgetUtils.spaceVertical(30),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerName,
                  maxLines: 1,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintFullname),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerMobile,
                  keyboardType: TextInputType.number,
                  maxLines: 1,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintMobile),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerEmail,
                  maxLines: 1,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintEmail),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Card(
                elevation: cardElevation,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(26))),
                child: TextField(
                  controller: _textEditingControllerPassword,
                  maxLines: 1,
                  obscureText: true,
                  style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                  decoration: UtilsImporter().styleUtils.textFieldDecoration(
                      UtilsImporter().stringUtils.hintPassword),
                ),
              ),
              UtilsImporter().widgetUtils.spaceVertical(40),
              InkWell(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: UtilsImporter()
                    .widgetUtils
                    .button(UtilsImporter().stringUtils.btnCreateAccount),
                onTap: () {
                  if (!UtilsImporter()
                      .commanUtils
                      .validateName(_textEditingControllerName.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunName, context);
                  } else if (!UtilsImporter()
                      .commanUtils
                      .validateMobile(_textEditingControllerMobile.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunNumber, context);
                  } else if (!UtilsImporter()
                      .commanUtils
                      .validateEmail(_textEditingControllerEmail.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunEmail, context);
                  } else if (!UtilsImporter()
                      .commanUtils
                      .validatePassword(_textEditingControllerPassword.text)) {
                    UtilsImporter().commanUtils.showToast(
                        UtilsImporter().stringUtils.retrunPassword, context);
                  } else {
                    Future<UserBean> userAuthData = UtilsImporter()
                        .firebaseAuthUtils
                        .signUpWithEmail(_textEditingControllerEmail.text,
                            _textEditingControllerPassword.text, context);
                    userAuthData.then((data) {
                      isLoginSuccess = data.isSuccess;
                      if (isLoginSuccess) {
                        setState(() {
                          _textEditingControllerEmail.text = '';
                          _textEditingControllerPassword.text = '';
                          _textEditingControllerMobile.text = '';
                          _textEditingControllerName.text = '';
                        });
                        UtilsImporter().commanUtils.showToast(
                            UtilsImporter().stringUtils.messageSuccess,
                            context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Login();
                        }));
                      }
                    });
                  }
                },
                splashColor: Colors.black,
              ),
              UtilsImporter().widgetUtils.spaceVertical(60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                side:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: Text(
                          UtilsImporter().stringUtils.labelSociaAccount,
                          style: TextStyle(
                              fontFamily:
                                  UtilsImporter().stringUtils.fontRoboto,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              UtilsImporter().widgetUtils.spaceVertical(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Future<UserBean> userAuthData = UtilsImporter()
                          .firebaseAuthUtils
                          .facebookLogin(context);

                      userAuthData.then((data) {
                        isLoginSuccess = data.isSuccess;
                        if (isLoginSuccess) {
                          UserBean _userBena = new UserBean(
                              data.fullname,
                              data.emailAddress,
                              data.phoneNumber,
                              data.profilPic,
                              data.isSuccess,
                              data.uid,
                              data.loginProvide);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Home(_userBena);
                          }));
                        }
                      });
                    },
                    splashColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    child: UtilsImporter()
                        .widgetUtils
                        .socialButton(UtilsImporter().stringUtils.icFacebook),
                  ),
                  UtilsImporter().widgetUtils.spacehorizontal(14),
                  InkWell(
                    onTap: () {
                      Future<UserBean> userAuthData = UtilsImporter()
                          .firebaseAuthUtils
                          .googleLogin(context);

                      userAuthData.then((data) {
                        isLoginSuccess = data.isSuccess;
                        if (isLoginSuccess) {
                          UserBean _userBena = new UserBean(
                              data.fullname,
                              data.emailAddress,
                              data.phoneNumber,
                              data.profilPic,
                              data.isSuccess,
                              data.uid,
                              data.loginProvide);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Home(_userBena);
                          }));
                        }
                      });
                    },
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    ),
                    splashColor: Colors.black,
                    child: UtilsImporter()
                        .widgetUtils
                        .socialButton(UtilsImporter().stringUtils.icGoogle),
                  ),
                  UtilsImporter().widgetUtils.spacehorizontal(14),
                  InkWell(
                    splashColor: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginWithMobile();
                      }));
                    },
                    child: UtilsImporter()
                        .widgetUtils
                        .socialButton(UtilsImporter().stringUtils.icPhone),
                  ),
                ],
              ),
              UtilsImporter().widgetUtils.spaceVertical(40),
            ],
          ),
        ),
      ),
    );
  }
}
