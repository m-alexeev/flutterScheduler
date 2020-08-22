// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoadingScreen.dart';
import 'package:flutter_app/screens/LoginScreen.dart';
import 'package:flutter_app/screens/MainScreen.dart';
import 'package:flutter_app/screens/RegisterScreen.dart';
import 'package:flutter_app/screens/WelcomeScreen.dart';


void main() {
  runApp(MyApp());
  //Temp user generation

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
     builder: (context, snapshot){
        if(snapshot.hasError){
          return LoadingScreen();
        }
        if (snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Welcome to Flutter',
            initialRoute: '/welcome',
            routes: {
              '/welcome' : (context) => WelcomeScreen(),
              '/signup' : (context) => RegisterScreen(),
              '/home' : (context) => MainScreen(),
              '/login' : (context) => LoginScreen(),
              '/loading' : (context) =>LoadingScreen(),
            },
          );
        }
        return LoadingScreen();
     }

     );
  }
}


