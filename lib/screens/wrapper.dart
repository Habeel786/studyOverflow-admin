import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/screens/authentication/authenticate.dart';
import 'package:testapp/screens/home/mainScreen.dart';

import 'home/home.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    print(user);
    // return either home or authenticate
    return (user==null)?Authenticate():MainScreen();
  }
}
