import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      if (imageFile != null) {
        _userImage = File(imageFile.path);
      }
    });
  }

  String _text = "";
  Future setDefaultImg() async {
    var storage = FirebaseStorage.instance;
  }

  @override
  Widget build(BuildContext context) {
    setDefaultImg();

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName),
      ),
      body: Scaffold(
        body: Column(
          children: [
            Text(_text + "TEST"),
            CircleAvatar(
              radius: 50,
              backgroundImage: _userImage == null
                  ? Image.asset(
                      'assets/defaults/profilePlaceHolder.png',
                      fit: BoxFit.fill,
                    ).image
                  : Image.file(_userImage).image,
            ),
            FlatButton.icon(
              label: Text("Upload Picture"),
              icon: Icon(Icons.image),
              color: Colors.blueAccent,
              onPressed: () => pickImageFromGallery(),
            ),
            FlatButton(
              child: Text("Push Image"),
              color: Colors.blueAccent,
              onPressed: () => _uploadImage(),
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

  void _uploadImage() async {
    var storage = FirebaseStorage.instance;


    String img = _userImage.path;
    String imgName = img
        .substring(img.lastIndexOf("/"), img.lastIndexOf("."))
        .replaceAll("/", "");

    final Directory tempDir = Directory.systemTemp;
    final byteData = await rootBundle.load(img);


    //get File from local path
    final file = File('${tempDir.path}/$imgName.png');
    //convert to Uint8 bytes, total of img bytes
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    StorageTaskSnapshot snapshot =
        await storage.ref().child("defaults/$imgName").putFile(file).onComplete;

    if (snapshot.error == null) {
      //get download url
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      //Create link in Firestore
      await FirebaseFirestore.instance
          .collection('defaults')
          .doc('userDefaults')
          .set({"url": downloadUrl, "profileImg": imgName});

      final snackBar = SnackBar(content: Text("Uploaded"));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      print("Error: ${snapshot.error.toString()}");
    }
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
