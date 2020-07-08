import 'package:flutter/material.dart';
import 'package:testapp/database.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DatabaseHandler().getData("python"),
        builder: (_ , snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Text("loading..."),
            );
          }else{
           return ListView.builder(
             itemCount: snapshot.data.length,
               itemBuilder: (_, index){
              return ListTile(
                title: Text(snapshot.data[index].data["Question"]),
                subtitle: Text(snapshot.data[index].data["Answer"]),
              );
            });
          }
        },
      ),
    );
  }
}
