import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/rounded_text_box.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFieldContainer(
                  child: passwordFormField(context),
                ),
                TextFieldContainer(
                  child: usernameFormField(context),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: saveButton(context),
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

  TextFormField usernameFormField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: "Username"),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter username';
        }
        return null;
      },
    );
  }

  TextFormField passwordFormField(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: "Password"),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );
  }

  Container saveButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print("Logged in!");
            }
          },
          child: Text(
            "Login",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
