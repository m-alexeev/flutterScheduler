import 'package:flutter/material.dart';

class AccountExists extends StatelessWidget {
  final bool login;
  final Function press;
  const AccountExists({
    Key key,
    this.login = true,
    this.press,
  }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don't have an Account ? " : "Already have an Account ? ",
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login? "Sign Up" : "Login",
            style: TextStyle(fontWeight: FontWeight.bold)
            ,
          ),
        )
      ],
    );
  }
}
