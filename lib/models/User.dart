import 'package:uuid/uuid.dart';

class User{
  String _userName;
  String _firstName;
  String _lastName;
  String _userID;

  User(String userName, String fName, String lName ){
    this._userName = userName;
    this._firstName = fName;
    this._lastName = lName;

    //Generate ID for user, may change later
    generateUserID();
  }

  String get fName {
    return _firstName;
  }

  String get lName{
    return _lastName;
  }

  String get userName{
    return _userName;
  }

  String get userID{
    return _userID;
  }

  void generateUserID(){
    var uuid = Uuid();
    this._userID = uuid.v1();
  }


}