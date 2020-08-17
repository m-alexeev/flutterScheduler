

import 'package:flutter/material.dart';
import 'package:flutter_app/models/UserManager.dart';
import 'package:flutter_app/screens/UserScreen.dart';


class MainScreen extends StatelessWidget{

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
    Text(
      'Index 2: Messenger',
      style: optionStyle,
    ),
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
