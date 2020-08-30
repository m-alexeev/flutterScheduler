import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/entry_form_field.dart';
import 'package:flutter_app/components/password_text_box.dart';
import 'package:flutter_app/models/User.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String errorMsg = "";

  final TextEditingController _usernameController =
      TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');
  final TextEditingController _repasswordController =
      TextEditingController(text: '');

  String _email = '';
  String _pwd = '';
  String _repwd = '';
  String _username = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordController.addListener(_updateValue);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _repasswordController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  _updateValue() {
    _pwd = _passwordController.text;
  }

  bool _autovalidate = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  onSaved: (input) => _email = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  icon: Icon(Icons.email),
                  hint: "Email",
                ),
                CustomTextField(
                  onSaved: (input) => _username = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  icon: Icon(Icons.person),
                  hint: "Username",
                ),
                CustomPasswordField(
                  onSaved: (input) => _pwd = input,
                  validator: (input) => input.isEmpty ? "*Required" : null,
                  icon: Icon(Icons.lock),
                  hint: "Password",
                  obscure: true,
                  controller: _passwordController,
                ),
                CustomPasswordField(
                  onSaved: (input) => _repwd = input,
                  validator: (input) =>
                      (input != _pwd) ? "Passwords do not match" : null,
                  icon: Icon(Icons.lock),
                  hint: "Confirm Password",
                  obscure: true,
                  controller: _repasswordController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: registerButton(
                      "REGISTER",
                      Colors.white,
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor,
                      Colors.white,
                      _validateRegisterInput),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: AccountExists(
                    login: false,
                    press: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (r) => false);
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget registerButton(String text, Color splashColor, Color highlightColor,
      Color fillColor, Color textColor, void validate()) {
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
        onPressed: () {
          validate();
        },
      ),
    );
  }

  void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()) {
      form.save();
      if (_pwd == _repwd) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');
        users.doc(_username).get().then((doc) async {
          //Check if username is taken
          try {
            if (!doc.exists) {
              auth.UserCredential user = await auth.FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _email, password: _pwd);
              //Check if email is taken
              if (user != null) {
                auth.User user = auth.FirebaseAuth.instance.currentUser;

                User localUser = User(_username, _email);
                users.doc(localUser.userName)
                    .set({
                      'username': localUser.userName,
                      'email': localUser.email,
                      'uid': user.uid,
                    })
                    .then((value) => print("User added"))
                    .catchError((error) => print("Failed to add user $error"));

                if (!user.emailVerified) {
                  await user.sendEmailVerification();
                  Navigator.pushNamed(context, '/verify-email');
                }
              }
            } else {
              print("Username is taken");
            }
          } catch (error) {
            errorMsg = error.toString();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Container(
                      child: Text(errorMsg),
                    ),
                  );
                });
          }
        });
      } else {
        print("passwords dont match");
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
