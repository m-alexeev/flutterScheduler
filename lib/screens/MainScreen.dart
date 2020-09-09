import 'package:flutter_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/MessageScreen.dart';
import 'file:///E:/FlutterProjects/flutter_app/lib/screens/auth/RegisterScreen.dart';
import 'package:flutter_app/screens/SettingsScreen.dart';

class MainScreen extends StatelessWidget {
  final String title;
  MainScreen({Key key, this.title, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {

  const NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  _NavBarState();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
    new MessageScreen(),
    new UserScreen(),
  ];


  void _onItemTapped(int index) {
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Calendar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Message"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
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
