import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/models/UserManager.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    UserManager manager = UserManager();
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
      ),
      body: Container(
        child: new Builder(
        builder: (context){
          return new ListView.builder(
              itemBuilder: (BuildContext context, int index){
                User user = manager.getUser(index);
                TextStyle widgetStyle =  new TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 24
                );
                return new Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Text("Name: " + user.fName,style: widgetStyle,),
                      new Text("Last Name: "+ user.lName, style: widgetStyle,),
                      new Text("User Name: "+ user.userName, style: widgetStyle,),
                      new Text("Last ID: "+ user.userID, style: widgetStyle,),
                    ],
                  ),
                );
              },
            itemCount: manager.getNumUsers(),
          );
        }

        ),
      ),
      );
  }
}

