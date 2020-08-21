import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/custom_form_field.dart';
import 'package:flutter_app/components/password_text_box.dart';
import 'package:flutter_app/components/rounded_text_box.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  String errorMsg = "";

  final TextEditingController _usernameController = TextEditingController(text: '');
  final TextEditingController _emailController = TextEditingController(text: '');
  final TextEditingController _passwordController = TextEditingController(text:'');
  final TextEditingController _repasswordController = TextEditingController(text: '');

  bool _autovalidate = true;

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
          autovalidate: _autovalidate,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFieldContainer(
                  child: CustomFormField(
                    controller: _emailController,
                    hint: "Email",
                  ),
                ),
                TextFieldContainer(
                    child: CustomFormField(
                    controller: _usernameController,
                    hint: "Username",
                  ),
                ),
                TextFieldContainer(
                  child: PasswordFormField(
                      controller: _passwordController,
                  ),
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              try {
                auth.UserCredential user = await auth.FirebaseAuth.instance.
                createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
                if (user != null){
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                }
              } on auth.FirebaseAuthException catch(e){
                print(e.code.toString());
                errorMsg = e.code;
                _formKey.currentState.validate();
              }catch (e){
                print(e.toString());
              }

            }
          },
          child: Text("Register",
          style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}

