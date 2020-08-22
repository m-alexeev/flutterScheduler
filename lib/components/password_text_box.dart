import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final FormFieldSetter<String> onSaved;
  final Icon icon;
  final String hint;
  final bool obscure;
  final FormFieldValidator validator;
  final TextEditingController controller;

  const CustomPasswordField({
    this.icon,
    this.hint,
    this.obscure,
    this.validator,
    this.onSaved,
    this.controller,
  });

  @override
  State<StatefulWidget> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField>{
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: widget.validator,
        autofocus: true,
        obscureText: _showPassword,
        controller: widget.controller,
        style: TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          hintText: widget.hint,
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
              child: widget.icon,
            ),
            padding: EdgeInsets.only(left: 30,right: 10),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {
                _showPassword = !_showPassword;

              });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    ) ;
  }
}
