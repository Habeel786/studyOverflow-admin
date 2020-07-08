import 'package:flutter/material.dart';
const textInputDecoration=InputDecoration(
  focusColor: Colors.pink,
  filled: true,
  fillColor:Colors.white,
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 2.0)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pink, width: 2.0)),
);
Future<bool> deleteDialogue(BuildContext context){
  return showDialog(
      context: null,
      builder: (BuildContext context){
        return new AlertDialog(
          title: Text('Are you sure?'),
          actions: [
            new FlatButton(onPressed:()=> Navigator.of(context).pop(true), child: Text('Yes')),
            new FlatButton(onPressed:()=> Navigator.of(context).pop(false), child: Text('No')),
          ],
        );
      }
  );
}