import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/LoginScreen.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Container(
        child: FlatButton(
          child: Text("Sign Out"),
          onPressed: () async =>_signOut(),
        ),
      ),
    );
  }

  void _signOut() async{
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await auth.FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => new LoginScreen()));
        });
      }
      catch(e){
        print(e.toString());
      }
    }
  }


}
