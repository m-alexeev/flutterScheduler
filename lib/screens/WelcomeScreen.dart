import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(

      body: Container(
        width: size.width,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    color: Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text("Login",
                      style: TextStyle(fontSize: 18),),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    color: Colors.grey,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: Text("Register",
                      style: TextStyle(fontSize: 18),),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
