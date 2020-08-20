import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/form_field.dart';
import 'package:flutter_app/components/password_text_box.dart';
import 'package:flutter_app/components/rounded_text_box.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _passwordController.dispose();
    super.dispose();
  }


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
                  child: CustomFormField(
                    hint: "Name"
                  ),
                ),
                TextFieldContainer(
                  child : CustomFormField(
                    hint: "Username",
                  ),
                ),
                PasswordFormField(
                    controller: _passwordController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: saveButton(context),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child : AccountExists(
                    login: false,
                    press: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (r)=>false);
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }


  //Validate User Creation
  //TODO: Use BLoc
  Container saveButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.6 ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          color: Colors.grey,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              print("Successfuly created user");
            }
          },
          child: Text("Register",
          style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}

