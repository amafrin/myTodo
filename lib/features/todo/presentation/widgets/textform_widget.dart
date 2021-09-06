import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget {
  TextEditingController controller;
  bool isPass;
  String hintText;

  TextFormWidget({Key key, this.controller, this.isPass, this.hintText})
      : super(key: key);

  @override
  _TextFormWidgetState createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        obscureText: (widget.isPass == true) ?? true ?? false,
        decoration: InputDecoration(
          hintText: widget.hintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      ),
    );
  }
}
