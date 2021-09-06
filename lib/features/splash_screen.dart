import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/constants/routing_constants.dart';
import 'package:flutter_clean_architechture/constants/string_constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.of(context).pushNamed(RoutingConstants.routeToSignIn),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: FlutterLogo(size: MediaQuery.of(context).size.height * 0.2)),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Text(
            StringConstants.splashScreenText,
            textAlign: TextAlign.center,
            style: TextStyle(
              
              fontSize:14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ),
    );
  }
}