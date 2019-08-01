import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/model/UserBean.dart';
import 'package:flutter_firebase_login/screens/CreateAccount.dart';
import 'package:flutter_firebase_login/screens/Home.dart';
import 'package:flutter_firebase_login/screens/LoginWithMobileNumber.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
      ),
      body: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double cardElevation = 8;
  bool isLoginSuccess = false;
  TapGestureRecognizer recognizerCreateAccount;
  TextEditingController _textEditingControllerEmail =
      new TextEditingController();
  TextEditingController _textEditingControllerPassword =
      new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recognizerCreateAccount = TapGestureRecognizer()
      ..onTap = () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CreateAccount();
        }));
      };
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(UtilsImporter().stringUtils.lableLoginAccount,
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
                  maxLines: 1,
                  controller: _textEditingControllerEmail,
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
                  maxLines: 1,
                  controller: _textEditingControllerPassword,
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
                    .button(UtilsImporter().stringUtils.btnLogin),
                onTap: () {
                  if (!UtilsImporter()
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
                    FocusScope.of(context).requestFocus(new FocusNode());
                    Future<UserBean> userAuthData = UtilsImporter()
                        .firebaseAuthUtils
                        .signInWithEmailAndPassword(
                            _textEditingControllerEmail.text,
                            _textEditingControllerPassword.text,
                            context);

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
                        setState(() {
                          _textEditingControllerEmail.text = '';
                          _textEditingControllerPassword.text = '';
                        });

                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Home(_userBena);
                        }));
                      }
                    });
                  }
                },
                splashColor: Colors.black,
              ),
              UtilsImporter().widgetUtils.spaceVertical(10),
              GestureDetector(
                child: Align(
                  child: Text(
                    UtilsImporter().stringUtils.txtForgetPassword,
                    style: TextStyle(
                        fontFamily: UtilsImporter().stringUtils.fontRoboto,
                        fontSize: 14),
                  ),
                  alignment: Alignment.topRight,
                ),
                onTap: () {
                  UtilsImporter()
                      .commanUtils
                      .showToast('Under Development', context);
                },
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
                          UtilsImporter().stringUtils.labelSociaLogin,
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
              Container(
                child: Align(
                  child: RichText(
                      text: TextSpan(children: <TextSpan>[
                    TextSpan(
                      text: UtilsImporter().stringUtils.lableNoaccount,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: UtilsImporter().stringUtils.fontRoboto),
                    ),
                    TextSpan(
                        text: UtilsImporter().stringUtils.labelCreate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: UtilsImporter().stringUtils.fontRoboto,
                          fontWeight: FontWeight.w700,
                        ),
                        recognizer: recognizerCreateAccount)
                  ])),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: button('Login'),
                      onTap: () {},
                      splashColor: Colors.black,
                    )
                    ),
                    Expanded(
                        child: InkWell(
                      child: button('Signup'),
                      onTap: () {},
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      splashColor: Colors.black,
                    ))
                  ],
                )*/
            ],
          ),
        ),
      ),
    );
  }
}
