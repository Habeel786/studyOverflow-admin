import 'package:flutter/material.dart';
import 'package:testapp/screens/authentication/register.dart';
import 'package:testapp/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignin=true;
  void toggleView(){
    setState(() {
      isSignin=!isSignin;
    });
  }
  @override
  Widget build(BuildContext context) {
    return isSignin?SignIn(toggleView: toggleView):Register(toggleView: toggleView);
  }
}
