import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserManager.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {


  @override
  Widget build(BuildContext context) {
    UserManager manager = UserManager();
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Container(
        child: FlatButton(
          child: Text("Sign Out"),
          onPressed: (){
              auth.FirebaseAuth.instance
                  .authStateChanges()
                  .listen((auth.User user) {
                    if (user != null){
                        auth.FirebaseAuth.instance.signOut();
                        //Navigator.pushNamedAndRemoveUntil(context,  '/login', (route) => false);
                      Navigator.pop(context);
                    }
              });
          }
        ),
      ),
      );
  }
}

