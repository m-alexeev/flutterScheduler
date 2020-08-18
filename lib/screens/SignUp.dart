import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          nameFormField(context),
          usernameFormField(context),
          Padding(
            padding: EdgeInsets.only(top : 16.0),
            child : saveButton(),
          )
      ]
      ),
    );
  }

  TextFormField nameFormField(BuildContext context){
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration (
        hintText: "Name"
      ),
      validator:( value){
        if (value.isEmpty){
          return 'Please enter name';
        }
        return null;
      }
    );
  }

  TextFormField usernameFormField(BuildContext context){
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: "Username"
      ),
      validator: (value){
        if (value.isEmpty){
          return 'Please enter username';
        }
        return null;
      },
    );
  }

  RaisedButton saveButton(){
    return RaisedButton(
      onPressed: (){
        if (_formKey.currentState.validate()){
          print("Successfuly created user");
        }
      },
      child: Text("Submit"),
    );
  }

}
