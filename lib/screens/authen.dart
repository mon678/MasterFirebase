import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  Widget SignupBotto() {
    return RaisedButton(
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text('Sign up'),
      onPressed: () {},
    );
  }

  Widget signInBotton() {
    return RaisedButton(
      color: Colors.orange,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text('Sign In'),
      onPressed: () {},
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'รหัสผ่าน:', hintText: 'ความยาว 6 ตัว'),
    );
  }

  Widget emailTextFormfield() {
    return TextFormField(
      decoration:
          InputDecoration(labelText: 'Email:', hintText: 'you@email.com'),
    );
  }

  Widget showAppName() {
    return Text(
      'Master Flutter นามสกุล',
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.white], begin: Alignment(-1, 1))),
        padding: EdgeInsets.only(top: 100.0),
        alignment: Alignment(0, -1),
        child: Column(
          children: <Widget>[
            Container(
              width: 200.0,
              height: 100.0,
              child: showlogo(),
            ),
            Container(margin: EdgeInsets.only(top: 50.0), child: showAppName()),
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
                      child: SignupBotto(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
