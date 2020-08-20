import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  final Widget child;
  final TextEditingController controller;

  const PasswordFormField({
    Key key,
    this.child,
    @required this.controller,
  })
      : assert(controller != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFormFieldState();
}

 class _PasswordFormFieldState extends State<PasswordFormField>{
  bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        border: null,
        color: Colors.grey,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: widget.controller,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            hintText: "Password",
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        obscureText: _showPassword,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter password';
          }
          return null;
        },
      ),
    );
  }
}
