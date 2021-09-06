import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  String buttonText;
  Function onTap;
   ButtonWidget({Key key,this.buttonText,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Center(
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
