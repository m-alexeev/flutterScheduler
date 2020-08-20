// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/material.dart';
import 'package:flutter_app/models/User.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/screens/MainScreen.dart';
import 'package:flutter_app/screens/SignUp.dart';

import 'models/UserManager.dart';

void main() {
  runApp(MyApp());
  //Temp user generation
  UserManager manager = UserManager();
  for (var i = 0 ; i < 5; i ++){
    manager.addToList(new User("userName $i", "Fname $i" , "Lname$i" ));
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return MaterialApp(
          title: 'Welcome to Flutter',
          initialRoute: '/signup',
       routes: {
            '/signup' : (context) => SignUpScreen(),
            '/home' : (context) => MainScreen(),
            '/login' : (context) => LoginScreen(),
       },
    );
  }
}


