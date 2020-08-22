import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final FormFieldValidator validator;

  CustomTextField({
    this.icon,
    this.hint,
    this.validator,
    this.onSaved});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
        onSaved: onSaved,
        validator: validator,
        autofocus: true,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 3,
            ),
          ),
          prefixIcon: Padding(
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).primaryColor),
              child: icon,
            ),
            padding: EdgeInsets.only(left: 30,right: 10),
          ),
        ),
      ),
    ) ;
  }
  }