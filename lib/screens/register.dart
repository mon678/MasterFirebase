import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
//Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  //For Firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

// For SnackBar
  final snackBarKey = GlobalKey<ScaffoldState>();

  Widget passwordTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            color: Colors.blue,
          ),
          labelText: 'Password :',
          hintText: 'More 6 Charactor',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey))),
      validator: (String value) {
        if (value.length <= 5) {
          return 'กรุณากรอกให้ครบ 6 ตัวอักษร';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey)),
          labelText: 'Email123 :',
          hintText: 'you@email.com',
          icon: Icon(
            Icons.email,
            color: Colors.green,
          )),
      validator: (String value) {
        if (value.length == 0) {
          return 'กรุณากรอก Email ';
        } else if (!((value.contains('@')) && (value.contains('.')))) {
          return 'กรุณากรอกรูปแบบ Email';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget nameTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(width: 1.0, color: Colors.grey)),
          labelText: 'Name :',
          hintText: 'Type Your Name',
          icon: Icon(
            Icons.face,
            color: Colors.red,
          )),
      validator: (String value) {
        if (value.length == 0) {
          return 'Please Fill Name In The Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget uploadButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      tooltip: 'Upload To Firebase',
      onPressed: () {
        print('You Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString, email=$emailString, password= $passwordString');
          uploadValueToFirebase(context);
        }
      },
    );
  }

  void uploadValueToFirebase(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((user) {
      print('Register Success with ===>> $user');

      addValueToDatabaseFirebase(context);

      // Navigator.pop(context);
    }).catchError((error) {
      String errorString = error.message;
      print('have error ====>> $errorString');
      showSnackBar(errorString);
    });
  }

  void addValueToDatabaseFirebase(BuildContext context) async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    String uidString = firebaseUser.uid.toString();
    print('uidString==>> $uidString');

    // create map type
    Map<String, String> map = Map();
    map['Name'] = nameString;
    map['Nation']='thai';

// Update Data to firebase

    await firebaseDatabase.reference().child(uidString).set(map);
    Navigator.pop(context);
  }

  void showSnackBar(String messageString) {
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor: Colors.red,
      content: Text(messageString),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );

    snackBarKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: snackBarKey,
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Register'),
          actions: <Widget>[uploadButton(context)],
        ),
        body: Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    colors: [Colors.white, Colors.purple[900]],
                    radius: 1.5,
                    center: Alignment(0, -1))),
            padding: EdgeInsets.all(50.0),
            child: Column(
              children: <Widget>[
                nameTextFormField(),
                Container(
                  margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: emailTextFormField(),
                ),
                passwordTextFormField()
              ],
            ),
          ),
        ));
  }
}
