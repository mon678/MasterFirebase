import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
// for firebas
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseDatabase firebaseDatabase=FirebaseDatabase.intState;



  Widget signOutButton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        print('You click signout ออกจาก');
        signOutProcess();
      },
    );
  }

  void signOutProcess() async {
    // signOut from firebase
    await firebaseAuth.signOut();

    // exit app
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyService'),
        actions: <Widget>[signOutButton()],
      ),
      body: Text('This is body'),
    );
  }
}
