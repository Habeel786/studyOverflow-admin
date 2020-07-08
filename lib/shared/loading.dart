import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.pinkAccent[50],
      body: Container(
        child: Center(
          child: SpinKitSquareCircle(
            color: Colors.pink,
            size: 50.0,
          ),
        ),
      ),

    );
  }
}
