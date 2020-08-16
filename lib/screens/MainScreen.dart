

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : "Home",
      home : navBar(),
    );
  }
}


class navBar extends StatefulWidget {
  @override
  _navBarState createState() => _navBarState();
}

class _navBarState extends State<navBar> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle (fontSize: 30, fontWeight: FontWeight.bold);


  //Change for Screen
  static const List<Widget> _widgetOptions = <Widget>[
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
    Text (
      'Index 3: Planner',
      style: optionStyle,
    )
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
