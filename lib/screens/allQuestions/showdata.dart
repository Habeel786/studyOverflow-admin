import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/database.dart';
import 'package:testapp/models/datamodel.dart';
import 'package:testapp/screens/home/home.dart';
import 'package:testapp/shared/constants.dart';
class QuestionList extends StatefulWidget {
  //final List sharedprefdata;
  final String subject;
  final String semester;
  final String stream;
  final String chapter;

  QuestionList({this.subject,this.semester,this.stream,this.chapter});

  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  var _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data= DatabaseHandler().dataAboutQues(widget.stream, widget.semester, widget.chapter,widget.subject);
  }
  @override
  Widget build(BuildContext context) {
    String answer="";
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Questions'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 65, 108, 1.0),
      ),
      body: StreamBuilder(
        stream:_data,
        builder: (_ , snapshot){
          List<Data> mydata= snapshot.data;
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: Text("loading..."),
            );
          }else{
            String shortAnswer(String answer){
              if(answer.length>34){
                return answer.substring(0,30)+"....";
              }else{
                return answer;
              }
            }
            return ListView.builder(
                itemCount: mydata.length,
                itemBuilder: (_, index){
                  return Card(
                    margin: EdgeInsets.fromLTRB(10,6,10,0),
                    child: ListTile(
                      onTap: (){
                        print(mydata[index].diagram);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(uanswer:mydata[index].answer,
                        uquestion:mydata[index].question,uchapter:mydata[index].chapter,udiagram: mydata[index].diagram,
                         uyearOfrepeat:mydata[index].yearofrepeat,umarks:mydata[index].marks,
                        usemester:mydata[index].semester,ustream: mydata[index].course,usubject: mydata[index].subject,
                        )));
                      },
                      title: Text(mydata[index].question),
                      subtitle: Text(shortAnswer(mydata[index].chapter
                          ??"")
                      ),
                      leading: Text(mydata[index].marks??"",
                        style: TextStyle(color: Colors.green),

                      ),
                      trailing: IconButton(icon: Icon(Icons.delete), onPressed: () async{
                        infoDialog(context,mydata[index].question, mydata[index].semester,mydata[index].diagram);
                      })
                    ),
                  );
                });
          }
        },
      ),
    );
  }

}
Future<bool> infoDialog(context,question,semester,diagram){
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context){
        return CupertinoAlertDialog(
          title: Text('Delete?'),
          content: Text('Delete this item?'),
          actions: [
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('No')),
            FlatButton(onPressed: ()async{
              await DatabaseHandler().deleteData(question,semester,diagram);
              Navigator.of(context).pop();
            }, child: Text('Yes')),
          ],
        );
      }
  );
}
