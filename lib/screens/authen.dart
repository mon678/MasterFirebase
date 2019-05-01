import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monfirebase/screens/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
// For Form
  final formKey = GlobalKey<FormState>();
// constant
  String titleHaveSpace = 'กรุณากรอกให้ครบ';
  String titleEmailFalse = 'กรุณากรอกรูปแบบที่กำหนด';
  String titlePasswordFale = 'รหัสต้องมีมากกว่า 6 ตัวอักษร';

  // Explicit ประกาศตัวแปรที่ไม่กำหนดค่า
  String emailString, passwordString;

  Widget SignupBotto(BuildContext context) {
    return RaisedButton.icon(
      icon: Icon(Icons.android),
      label: Text('Sign Up'),
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print('You click sign up');
        var registerRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(registerRoute);
      },
    );
  }

  Widget signInBotton() {
    return RaisedButton.icon(
      label: Text('Sign In'),
      icon: Icon(Icons.account_circle),
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        print('You click SignIn');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print('email===>> $emailString, password==>> $passwordString');
        }
      },
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'รหัสผ่าน:', hintText: 'ความยาว 6 ตัว'),
      validator: (String value) {
        if (value.length <= 5) {
          return titlePasswordFale;
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget emailTextFormfield() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'จดหมายอิเล็กทรอนิกส์:', hintText: 'you@email.com'),
      validator: (String value) {
        if (value.length == 0) {
          return titleHaveSpace;
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return titleEmailFalse;
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget showAppName() {
    return Text(
      'ระบบ Master Flutter',
      style: TextStyle(
          fontFamily: 'Itim-Regular',
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800]),
    );
  }

  Widget showlogo() {
    return Image.asset('images/logo.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue, Colors.white],
                    begin: Alignment(-1, 1))),
            padding: EdgeInsets.only(top: 100.0),
            alignment: Alignment(0, -1),
            child: Column(
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 100.0,
                  child: showlogo(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 50.0), child: showAppName()),
                Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: emailTextFormfield(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: passwordTextFormField(),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 4.0),
                          child: signInBotton(),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 5.0),
                          child: SignupBotto(context),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
