import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/database.dart';
import 'package:testapp/models/subjectnamemodel.dart';
import 'package:testapp/screens/allQuestions/showdata.dart';
class UpdateData extends StatefulWidget {
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {

  final _formkey = GlobalKey<FormState>();
  List streams=['computer engineering','BSC','Commerce','Arts','Civil Engineering'];
  List semesters=['1','2','3','4','5','6','7','8'];
  List subjects=['mobile application development','python'];
  String _currentStream;
  String _currentSubject;
  String _currentSemester;
  String _currentChapter;
  String chapter;
  String subject;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.pinkAccent,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left:30.0,right: 30.0,),
            child: Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  //--------------stream--------------//
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[200]))
                      ),
                      child: DropdownButtonFormField(
                        value:_currentStream,
                        items: streams.map((stream){
                          return DropdownMenuItem(
                            value: stream,
                            child: Text("$stream"),
                          );
                        }).toList(),
                        onChanged: (val)=> setState(()=>_currentStream=val),
                        decoration: InputDecoration(
                            labelText: "Stream",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),

                  //--------------stream--------------//

                  //---------------semester------------//
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey[200]))
                      ),
                      child: DropdownButtonFormField(
                        value:_currentSemester,
                        items: semesters.map((semester){
                          return DropdownMenuItem(
                            value: semester,
                            child: Text("$semester"),
                          );
                        }).toList(),
                        onChanged: (val)=> setState(()=>_currentSemester=val),
                        decoration: InputDecoration(
                            labelText: 'Semester',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  //subject
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                    ),
                    child: StreamBuilder(
                        stream: DatabaseHandler().getThumbnail(_currentStream??'computer engineering',_currentSemester??'6'),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            SubjectThumbnail subjectThumbnail = snapshot.data;
                            List<dynamic> names=subjectThumbnail.thumbnail.keys.toList();
                            return DropdownButtonFormField(
                              isExpanded: true,
                              value: _currentSubject,
                              items: names.map((subject){
                                return DropdownMenuItem(
                                  value: subject,
                                  child: Text("$subject"),
                                );
                              }).toList(),
                              onChanged: (val)=> setState(()=>_currentSubject=val),
                              decoration: InputDecoration(
                                  labelText: 'Subject',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            );
                          }else{
                            return Text('please select stream and semester first');
                          }
                        }
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
                    ),
                    child: StreamBuilder(
                        stream: DatabaseHandler().getChapterNames(_currentSubject??'mobile application development'),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            ChapterNames chapterNames = snapshot.data;
                            List names=chapterNames.chapternames;
                            return DropdownButtonFormField(
                              isExpanded: true,
                              value: _currentChapter,
                              items: names.map((chapter){
                                return DropdownMenuItem(
                                  value: chapter,
                                  child: Text("$chapter"),
                                );
                              }).toList(),
                              onChanged: (val)=> setState(()=>_currentChapter=val),
                              decoration: InputDecoration(
                                  labelText: 'Chapter',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                              ),
                            );
                          }else{
                            return Text('select subject first');
                          }

                        }
                    ),
                  ),
//                    Container(
//                    padding: EdgeInsets.all(10),
//                    decoration: BoxDecoration(
//                        border: Border(bottom: BorderSide(color: Colors.grey[200]))
//                    ),
//                    child: DropdownButtonFormField(
//                      value:_currentSubject,
//                      items: subjects.map((subject){
//                        return DropdownMenuItem(
//                          value: subject,
//                          child: Text("$subject"),
//                        );
//                      }).toList(),
//                      onChanged: (val)=> setState(()=>_currentSubject=val),
//                      decoration: InputDecoration(
//                          labelText: 'Subject',
//                          hintStyle: TextStyle(color: Colors.grey),
//                          border: InputBorder.none
//                      ),
//                    ),
//                  ),
                  SizedBox(height: 40,),
                  RaisedButton(
                    child: Text("Get Questions",style: TextStyle(color: Colors.white,),),
                    color: Colors.pinkAccent,
                    onPressed: ()async{
                      print(_currentStream);
                      print(_currentSemester);
                      print(_currentSubject);
                      print(_currentChapter);
                      Navigator.push(context, MaterialPageRoute(builder:(context)=> QuestionList(stream: _currentStream,semester: _currentSemester,subject: _currentSubject,chapter: _currentChapter,)));
                    },
                  )
//                    InkWell(
//                    onTap: ()async{
//                            print(_currentStream);
//                            print(_currentSemester);
//                            print(_currentSubject);
//                            print(_currentChapter);
//                      Navigator.push(context, MaterialPageRoute(builder:(context)=> QuestionList(stream: _currentStream,semester: _currentSemester,subject: _currentSubject,chapter: _currentChapter,)));
//
//                    },
//                    child: Container(
//                      height: 50,
//                      margin: EdgeInsets.symmetric(horizontal: 50),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(50),
//                          gradient: LinearGradient(
//                              begin: Alignment.topCenter,
//                          )
//                      ),
//                      child: Center(
//                        child: Text("Get Questions", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
//                      ),
//                    ),
//                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
