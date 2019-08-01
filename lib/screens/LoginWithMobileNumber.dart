import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_login/utils/UtilsImporter.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter_firebase_login/screens/Home.dart';
import 'package:flutter_firebase_login/model/UserBean.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginWithMobile extends StatelessWidget {
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
      body: LoginWithMobileScreen(),
    );
  }
}

class LoginWithMobileScreen extends StatefulWidget {
  @override
  _LoginWithMobileScreenState createState() => _LoginWithMobileScreenState();
}

class _LoginWithMobileScreenState extends State<LoginWithMobileScreen> {
  double cardElevation = 8;
  String _message = '';
  String _verificationId;
  Country _selectedCountry;
  bool istextFieldOTPVisible = false;
  bool isPhoneButton = true;
  bool isPhoneClickIgnor = false;
  int timeoutOTP = 00;
  Color phoneButtonColors = Colors.black;
  bool isLoginSuccess = false;
  String verficationOTPMessage = '';
  TextEditingController _textEditingControllerMobileNumber =
      new TextEditingController();

  final FocusNode _1InputFocusNode = new FocusNode();
  final FocusNode _2InputFocusNode = new FocusNode();
  final FocusNode _3InputFocusNode = new FocusNode();
  final FocusNode _4InputFocusNode = new FocusNode();
  final FocusNode _5InputFocusNode = new FocusNode();
  final FocusNode _6InputFocusNode = new FocusNode();

  TextEditingController _1textEditingControllerOTP =
      new TextEditingController();
  TextEditingController _2textEditingControllerOTP =
      new TextEditingController();
  TextEditingController _3textEditingControllerOTP =
      new TextEditingController();
  TextEditingController _4textEditingControllerOTP =
      new TextEditingController();
  TextEditingController _5textEditingControllerOTP =
      new TextEditingController();
  TextEditingController _6textEditingControllerOTP =
      new TextEditingController();

  String strButtonPhone = UtilsImporter().stringUtils.btnSendOTP;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: <Widget>[
          Text(UtilsImporter().stringUtils.lableLoginMobile,
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: CountryPicker(
                    dense: false,
                    showFlag: false,
                    showDialingCode: true,
                    showName: false,
                    onChanged: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                      });
                    },
                    selectedCountry: _selectedCountry,
                  ),
                  flex: 3,
                ),
                Expanded(
                  child: IgnorePointer(
                    ignoring: isPhoneClickIgnor,
                    child: TextField(
                      controller: _textEditingControllerMobileNumber,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      keyboardAppearance: Brightness.light,
                      textInputAction: TextInputAction.done,
                      style: UtilsImporter().styleUtils.loginTextFieldStyle(),
                      decoration: UtilsImporter()
                          .styleUtils
                          .textFieldDecoration(
                              UtilsImporter().stringUtils.hintMobile),
                    ),
                  ),
                  flex: 6,
                ),
              ],
            ),
          ),
          UtilsImporter().widgetUtils.spaceVertical(30),
          IgnorePointer(
            ignoring: isPhoneClickIgnor,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: UtilsImporter()
                  .widgetUtils
                  .buttonVerification(strButtonPhone, phoneButtonColors),
              onTap: () {
                if (!UtilsImporter().commanUtils.validateMobile(
                    _selectedCountry.dialingCode +
                        _textEditingControllerMobileNumber.text)) {
                  UtilsImporter().commanUtils.showToast(
                      UtilsImporter().stringUtils.retrunNumber, context);
                  setState(() {
                    istextFieldOTPVisible = false;
                  });
                } else {
                  setState(() {
                    _verifyPhoneNumber();
                  });
                }
              },
              splashColor: Colors.black,
            ),
          ),
          UtilsImporter().widgetUtils.spaceVertical(30),
          Visibility(
            visible: istextFieldOTPVisible,
            child: Countdown(
              duration: Duration(seconds: timeoutOTP),
              onFinish: () {
                setState(() {
                  istextFieldOTPVisible = false;
                  isPhoneClickIgnor = false;
                  verficationOTPMessage = "";
                  phoneButtonColors = Colors.black;
                  timeoutOTP = 00;
                  strButtonPhone = UtilsImporter().stringUtils.btnReSendOTP;
                });
              },
              builder: (BuildContext ctx, Duration remaining) {
                return Text(
                  verficationOTPMessage +
                      ':' +
                      '${remaining.inMinutes}:${remaining.inSeconds}',
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: UtilsImporter().stringUtils.fontRoboto),
                );
              },
            ),
          ),
          UtilsImporter().widgetUtils.spaceVertical(30),
          Visibility(
            visible: istextFieldOTPVisible,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(UtilsImporter().stringUtils.lableEnterOPT,
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: UtilsImporter().stringUtils.fontRoboto,
                    fontSize: 20,
                  )),
            ),
          ),
          UtilsImporter().widgetUtils.spaceVertical(10),
          Visibility(
            visible: istextFieldOTPVisible,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textFieldOTP(_1InputFocusNode, 1, _1textEditingControllerOTP),
                textFieldOTP(_2InputFocusNode, 2, _2textEditingControllerOTP),
                textFieldOTP(_3InputFocusNode, 3, _3textEditingControllerOTP),
                textFieldOTP(_4InputFocusNode, 4, _4textEditingControllerOTP),
                textFieldOTP(_5InputFocusNode, 5, _5textEditingControllerOTP),
                textFieldOTP(_6InputFocusNode, 6, _6textEditingControllerOTP),
              ],
            ),
          ),
          UtilsImporter().widgetUtils.spaceVertical(30),
          Visibility(
            visible: istextFieldOTPVisible,
            child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: UtilsImporter()
                  .widgetUtils
                  .button(UtilsImporter().stringUtils.btnSubmitOTP),
              onTap: () {
                if (!UtilsImporter().commanUtils.validateOTP(
                    _1textEditingControllerOTP.text +
                        _2textEditingControllerOTP.text +
                        _3textEditingControllerOTP.text +
                        _4textEditingControllerOTP.text +
                        _5textEditingControllerOTP.text +
                        _6textEditingControllerOTP.text)) {
                  UtilsImporter().commanUtils.showToast(
                      UtilsImporter().stringUtils.retrunNumber, context);
                } else {
                  Future<UserBean> userAuthData = _signInWithPhoneNumber(
                      _1textEditingControllerOTP.text +
                          _2textEditingControllerOTP.text +
                          _3textEditingControllerOTP.text +
                          _4textEditingControllerOTP.text +
                          _5textEditingControllerOTP.text +
                          _6textEditingControllerOTP.text);
                  userAuthData.then((data) {
                    isLoginSuccess = data.isSuccess;
                    UserBean _userBena = new UserBean(
                        data.fullname,
                        data.emailAddress,
                        data.phoneNumber,
                        data.profilPic,
                        data.isSuccess,
                        data.uid,
                        data.loginProvide);
                    if (isLoginSuccess) {
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
          ),
        ],
      ),
    ));
  }

  Widget textFieldOTP(FocusNode covariant, int txtfieldPostion,
      TextEditingController textEditingController) {
    return Flexible(
      child: Card(
        elevation: cardElevation,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                width: 50,
                height: 50,
                child: TextField(
                  controller: textEditingController,
                  focusNode: covariant,
                  keyboardType: TextInputType.phone,
                  keyboardAppearance: Brightness.light,
                  textAlign: TextAlign.center,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                  ],
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  onChanged: (String calus) {
                    switch (txtfieldPostion) {
                      case 1:
                        if (calus.length == 1) {
                          _1textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(_2InputFocusNode);
                        }
                        break;
                      case 2:
                        if (calus.length == 1) {
                          _2textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(_3InputFocusNode);
                        } else if (calus.length == 0) {
                          FocusScope.of(context).requestFocus(_1InputFocusNode);
                        }
                        break;
                      case 3:
                        if (calus.length == 1) {
                          _3textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(_4InputFocusNode);
                        } else if (calus.length == 0) {
                          FocusScope.of(context).requestFocus(_2InputFocusNode);
                        }
                        break;
                      case 4:
                        if (calus.length == 1) {
                          _4textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(_5InputFocusNode);
                        } else if (calus.length == 0) {
                          FocusScope.of(context).requestFocus(_3InputFocusNode);
                        }
                        break;
                      case 5:
                        if (calus.length == 1) {
                          _5textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(_6InputFocusNode);
                        } else if (calus.length == 0) {
                          FocusScope.of(context).requestFocus(_4InputFocusNode);
                        }
                        break;
                      case 6:
                        if (calus.length == 0) {
                          FocusScope.of(context).requestFocus(_5InputFocusNode);
                        } else {
                          _6textEditingControllerOTP.text = calus;
                          FocusScope.of(context).requestFocus(new FocusNode());
                        }
                        break;
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }

  void _verifyPhoneNumber() async {
    setState(() {
      _message = '';
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _message = 'Received phone auth credential: $phoneAuthCredential';
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        istextFieldOTPVisible = false;
        isPhoneClickIgnor = false;
        verficationOTPMessage = "";
        phoneButtonColors = Colors.black;
        timeoutOTP = 00;
        strButtonPhone = UtilsImporter().stringUtils.btnReSendOTP;
        _message =
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}';
      });
      print('====Phone Error 2: ' + _message);
      UtilsImporter().commanUtils.showToast(_message, context);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      /* widget._scaffold.showSnackBar(SnackBar(
        content:
        const Text('Please check your phone for the verification code.'),
      ));*/

      _verificationId = verificationId;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
    };

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: '+' +
              _selectedCountry.dialingCode +
              _textEditingControllerMobileNumber.text,
          timeout: const Duration(seconds: 60),
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
      setState(() {
        verficationOTPMessage = 'Please enter verification send to ' +
            _textEditingControllerMobileNumber.text +
            ' Remaing time ';
        istextFieldOTPVisible = true;
        isPhoneClickIgnor = true;
        phoneButtonColors = Colors.grey;
        timeoutOTP = 60;
      });
      UtilsImporter().commanUtils.showToast(
          'Please check your phone for the verification code.', context);
    } on PlatformException catch (error) {
      setState(() {
        istextFieldOTPVisible = false;
        isPhoneClickIgnor = false;
        verficationOTPMessage = "";
        phoneButtonColors = Colors.black;
        timeoutOTP = 00;
        strButtonPhone = UtilsImporter().stringUtils.btnReSendOTP;
      });
      print('====Phone Error 0: ' + _message);
      UtilsImporter().commanUtils.showToast(error.message, context);
    }
  }

  Future<UserBean> _signInWithPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: smsCode,
    );
    FirebaseUser user;
    String errorMessage = 'Sign in failed';
    UserBean bean;

    try {
      user = (await _auth.signInWithCredential(credential));
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
    } on PlatformException catch (error) {
      errorMessage = error.message;
      print('====Phone Error 1: ' + errorMessage);
      UtilsImporter().commanUtils.showToast(error.message, context);
      setState(() {
        istextFieldOTPVisible = false;
        isPhoneClickIgnor = false;
        verficationOTPMessage = "";
        phoneButtonColors = Colors.black;
        timeoutOTP = 00;
        strButtonPhone = UtilsImporter().stringUtils.btnReSendOTP;
      });
    }

    setState(() {
      if (user != null) {
        bean = new UserBean(
            '',
            '',
            '',
            UtilsImporter().stringUtils.userPlaceHolder,
            true,
            user.uid,
            'phonenumber');
        _message = 'Successfully signed in, uid: ';
      } else {
        bean = new UserBean(
            '',
            '',
            '',
            UtilsImporter().stringUtils.userPlaceHolder,
            false,
            '',
            'phonenumber');
        _message = errorMessage;
      }
      UtilsImporter().commanUtils.showToast(_message, context);
    });

    return bean;
  }
}
