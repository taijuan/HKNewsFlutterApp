import 'dart:async';

import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static final String sName = "/";

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool hadInit = false;

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "HomePage");
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Center(
            child: Image(image: AssetImage("images/welcome_logo.webp"))));
  }
}
