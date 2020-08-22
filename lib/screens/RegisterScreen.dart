
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/AccountExists.dart';
import 'package:flutter_app/components/custom_form_field.dart';
import 'package:flutter_app/components/entry_form_field.dart';
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

  String _email = '';
  String _pwd = '';
  String _repwd = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _passwordController.addListener(_updateValue);
  }

  @override
  void dispose(){
    _passwordController.dispose();
    _repasswordController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  _updateValue(){
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
                  validator: (input) =>input.isEmpty? "*Required" : null,
                  icon: Icon(Icons.email) ,
                  hint: "Email",
                ),
                CustomPasswordField(
                  onSaved: (input) => _pwd = input,
                  validator: (input) =>input.isEmpty? "*Required" : null,
                  icon: Icon(Icons.lock),
                  hint: "Password",
                  obscure: true,
                  controller: _passwordController,
                ),
                CustomPasswordField(
                  onSaved: (input) => _repwd = input,
                  validator: (input) => (input != _pwd)? "Passwords do not match" : null,
                  icon: Icon(Icons.lock),
                  hint: "Confirm Password",
                  obscure: true,
                  controller: _repasswordController,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: saveButton("REGISTER",Colors.white,Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,Colors.white,_validateRegisterInput),
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

Widget saveButton(String text, Color splashColor, Color highlightColor,
        Color fillColor, Color textColor, void validate()){
  Size size = MediaQuery.of(context).size;

  return Container(
      width: size.width * 0.6 ,
      height: 50,
      child: FlatButton(
        splashColor: splashColor,
        highlightColor: highlightColor,
        color: fillColor,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(20)
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,color: textColor,fontSize: 20
          ),
        ),
        onPressed: (){
          validate();
        },
      ),
    );
}

void _validateRegisterInput() async {
    final FormState form = _formKey.currentState;
    if (_formKey.currentState.validate()){
      form.save();
      if (_pwd == _repwd) {

        try {
          auth.UserCredential user = await auth.FirebaseAuth.instance.
          createUserWithEmailAndPassword(email: _email, password: _pwd);
          if (user != null) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
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
      }
      else{
        print("passwords dont match");
      }
    }else{
      setState(() {
        _autovalidate = true;
      });
    }
}



//  //Validate User Creation
//  //TODO: Use BLoc
//  Container saveButton(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Container(
//      width: size.width * 0.6 ,
//      child: ClipRRect(
//        borderRadius: BorderRadius.circular(29),
//        child: FlatButton(
//          color: Colors.grey,
//          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//          onPressed: () async {
//            if (_formKey.currentState.validate()) {
//              try {
//                auth.UserCredential user = await auth.FirebaseAuth.instance.
//                createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
//                if (user != null){
//                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
//                }
//              } on auth.FirebaseAuthException catch(e){
//                print(e.code.toString());
//                errorMsg = e.code;
//                _formKey.currentState.validate();
//              }catch (e){
//                print(e.toString());
//              }
//
//            }
//          },
//          child: Text("Register",
//          style: TextStyle(fontSize: 18),),
//        ),
//      ),
//    );
//  }
}

