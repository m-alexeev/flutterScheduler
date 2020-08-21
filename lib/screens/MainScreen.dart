

import 'package:flutter/material.dart';
import 'package:flutter_app/screens/RegisterScreen.dart';
import 'package:flutter_app/screens/UserScreen.dart';


class MainScreen extends StatelessWidget{
  final String title;
  MainScreen({Key key, this.title}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "Home",
      home : NavBar(),
    );
  }
}


class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle (fontSize: 30, fontWeight: FontWeight.bold);


  //Change for Screen
  final _widgetOptions = [
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Calendar',
      style: optionStyle,
    ),
    new RegisterScreen(),
    new UserScreen(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon : Icon(Icons.calendar_today),
            title: Text ("Calendar"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title : Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title : Text ("Message"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            title : Text ("Message"),
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,

      ),
    );
  }
}
