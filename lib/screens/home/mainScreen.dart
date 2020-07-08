import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:testapp/screens/home/home.dart';
import 'package:testapp/update/updatequestion.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex=0;
  final tabs=[
    Home(),
    UpdateData(),
  ];
  @override
  Widget build(BuildContext context) {
            return  Scaffold(
              body:tabs[currentIndex] ,
              bottomNavigationBar: BottomNavyBar(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: Colors.white,
                selectedIndex: currentIndex,
                showElevation: false,
                itemCornerRadius: 8,
                curve: Curves.easeInBack,
                onItemSelected: (index) => setState(() {
                  currentIndex = index;
                }),
                items: [
                  BottomNavyBarItem(
                    icon: Icon(Icons.apps),
                    title: Text('Home'),
                    activeColor: Colors.red,
                    textAlign: TextAlign.center,
                  ),
                  BottomNavyBarItem(
                    icon: Icon(Icons.add_box),
                    title: Text('Update'),
                    activeColor: Colors.purpleAccent,
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            );
          }
        }
