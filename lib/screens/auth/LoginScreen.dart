import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/entry_form_field.dart';
import 'package:flutter_app/components/password_text_box.dart';
import 'package:flutter_app/components/rounded_text_box.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key key,
}): super (key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();


  final TextEditingController _passwordController = TextEditingController();
  String _pwd = '';


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
                CustomTextField(
                  onSaved: (input) => _pwd = input,
                  validator: (input) =>input.isEmpty? "*Required" : null,
                  icon: Icon(Icons.lock),
                  hint: "Email",
                ),
                CustomPasswordField(
                  onSaved: (input) => _pwd = input,
                  validator: (input) =>input.isEmpty? "*Required" : null,
                  icon: Icon(Icons.lock),
                  hint: "Password",
                  obscure: true,
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
                      Navigator.pushNamedAndRemoveUntil(context, '/signup', (r)=>false);
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
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
