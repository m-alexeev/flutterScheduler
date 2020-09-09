import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/auth/LoginScreen.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var user = auth.FirebaseAuth.instance.currentUser;

  final picker = ImagePicker();
  File _userImage;
  Future pickImageFromGallery() async {
    final imageFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _userImage = File(imageFile.path);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
      ),
      body: Scaffold(
        body: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _userImage == null
                  ? Image.network("https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg").image
                  : Image.file(_userImage).image,
            ),
            FlatButton.icon(
              label: Text("Upload Picture"),
              icon: Icon(Icons.image),
              color: Colors.blueAccent,
              onPressed: () => pickImageFromGallery(),
            ),
            FlatButton(
              child: Text("Sign Out"),
              onPressed: () async => _signOut(),
            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    auth.User user = auth.FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await auth.FirebaseAuth.instance.signOut().then((value) {
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => new LoginScreen()));
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
