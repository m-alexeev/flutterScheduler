// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/LoadingScreen.dart';
import 'package:flutter_app/screens/MainScreen.dart';
import 'file:///E:/FlutterProjects/flutter_app/lib/screens/auth/LoginScreen.dart';
import 'package:flutter_app/screens/SettingsScreen.dart';
import 'file:///E:/FlutterProjects/flutter_app/lib/screens/auth/RegisterScreen.dart';
import 'package:flutter_app/screens/WelcomeScreen.dart';
import 'package:flutter_app/screens/auth/VerifyEmailScreen.dart';

void main() {
  runApp(MyApp());
  //Temp user generation
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String initialRoute = '/login';
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return LoadingScreen();
          }
          if (snapshot.connectionState == ConnectionState.done){

            // Check for user Auth, auto login
            auth.User user =  auth.FirebaseAuth.instance.currentUser;
            if (user != null){
              print(user);
              initialRoute = '/home';
            }

            return MaterialApp(
              title: 'Welcome to Flutter',
              initialRoute: initialRoute,
              routes: {
                '/welcome': (context) => WelcomeScreen(),
                '/signup': (context) => RegisterScreen(),
                '/home': (context) => MainScreen(),
                '/login': (context) => LoginScreen(),
                '/loading': (context) => LoadingScreen(),
                '/verify-email': (context) => VerifyEmailScreen(),
                '/user' : (context) =>UserScreen(),
              },
            );
          }
          return LoadingScreen();
        });
  }
}
