import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/custom_form_field.dart';
import 'package:flutter_app/components/entry_form_field.dart';

class VerifyEmailScreen extends StatefulWidget {
  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String _code = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Form(
            autovalidate: false,
            key : _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Verify Email", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                Text("Enter 6 digit code"),
                CustomTextField(
                  onSaved: (input) => _code = input,
                  icon: Icon(Icons.lock) ,
                  hint: "Code",
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: verifyButton(),
                ),
              ],
            ),
          ),
      ),
    );
  }

  Widget verifyButton(){
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.5,
      child: FlatButton(
        color: Theme.of(context).primaryColor,
        highlightColor: Theme.of(context).primaryColor ,
        splashColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20)
        ),
        child: Text("Verify"),
        onPressed: () async{
            User user =  FirebaseAuth.instance.currentUser;
            user.reload();
            if (user.emailVerified){
                print("Verified");
                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }
            else {
              print("${user.email}  ${user.emailVerified}");
            }
          },

      ),
    );

  }



}
