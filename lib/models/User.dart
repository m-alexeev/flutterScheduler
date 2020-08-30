import 'package:uuid/uuid.dart';

class User{
  String _userName;
  String _email;

  User(String userName, String email ){
    this._userName = userName;
    this._email = email;
    //Generate ID for user, may change later
  }

  String get email{
    return _email;
  }

  String get userName{
    return _userName;
  }




}