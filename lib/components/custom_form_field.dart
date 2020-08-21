
import 'package:flutter/material.dart';

class CustomFormField extends StatefulWidget {
  final String hint;
  final String error;
  final TextEditingController controller;
  CustomFormField({
    Key key,
    @required this.controller,
    this.hint,
    this.error,
  }): assert(controller != null),
        super( key : key );

  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: widget.hint),

      validator: (value) {
        if (value.isEmpty ) {
          return "${widget.hint} field is empty";
        }
        return null;
      },
    );
  }
}
