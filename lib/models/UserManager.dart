import 'package:flutter_app/models/User.dart';

class UserManager{
  static final UserManager _manager = UserManager._internal();
  List<User> _userList = new List.empty(growable: true);

  factory UserManager(){
    return _manager;
  }
  UserManager._internal();

  void addToList(User user){
    _userList.add(user);
  }

  void removeFromList(int index){
    if (index >= _userList.length){
      print("Invalid Length");
    }
    else{
      _userList.removeAt(index);
    }
  }

  User getUser(int index){
    if (index >= _userList.length){
      print("Invalid Index");
      return null;
    }
    else{
      return _userList.elementAt(index);
    }
  }

  int getNumUsers(){
    return _userList.length;
  }
}