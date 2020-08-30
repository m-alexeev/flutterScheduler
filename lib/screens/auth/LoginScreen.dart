import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/entry_form_field.dart';
import 'package:flutter_app/components/password_text_box.dart';
import 'package:flutter_app/screens/MainScreen.dart';


class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  String _pwd = '';
  String _email = '';

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user);
    }

    return new Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  onSaved: (input) => _email = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  icon: Icon(Icons.email),
                  hint: "Email",
                ),
                CustomPasswordField(
                  onSaved: (input) => _pwd = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  icon: Icon(Icons.lock),
                  hint: "Password",
                  obscure: true,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: loginButton(
                      "Login",
                      Colors.white,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                      Colors.white,
                      _validateLoginInput),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: AccountExists(
                    login: true,
                    press: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget loginButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, Future validate()) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.6,
      height: 50,
      child: FlatButton(
        splashColor: splashColor,
        highlightColor: highlightColor,
        color: fillColor,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
        ),
        onPressed: () async {
          await validate();
        },
      ),
    );
  }

  Future<void> _validateLoginInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      try {
        await auth.FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _pwd)
            .then((value) async {
              //Redirect
              auth.User user = auth.FirebaseAuth.instance.currentUser;
              if (user != null) {
                //Query Database for username
                CollectionReference users = FirebaseFirestore.instance.collection('users');
                await users.where('email', isEqualTo: user.email).get().then((value) {
                  if (value != null){
                    print (value.toString());
                    Navigator.pushReplacement(context,
                        new MaterialPageRoute(
                            builder: (context) => new MainScreen()));
                  }
                  else {
                    print("User does not exist");
                  }
                });
          }
        });
      } catch (error) {
        print("err" + error.toString());
      }
    } else {
      print("passwords dont match");
    }
  }
}
