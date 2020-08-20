import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hint;
  final String error;
  const CustomFormField({
    Key key,
    this.hint,
    this.error,
  }): super( key : key );

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: widget.hint),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter $widget.hint';
        }
        return null;
      },
    );
  }
}
