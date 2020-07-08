//import 'dart:io';
//import 'package:flutter/material.dart';
//import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:testapp/database.dart';
//import 'package:testapp/models/subjectnamemodel.dart';
//import 'package:testapp/services/auth.dart';
//import 'package:testapp/services/imageuploadservice.dart';
//import 'package:testapp/shared/constants.dart';
//import 'package:testapp/shared/loading.dart';
//import 'package:testapp/update/updatequestion.dart';
//class Home extends StatefulWidget {
//  String uyearOfrepeat;
//  String uquestion;
//  String uanswer;
//  String usubject;
//  String ustream;
//  String usemester;
//  String umarks;
//  String uchapter;
//  String udiagram;
//  Home({this.uyearOfrepeat, this.uquestion, this.uanswer, this.usubject,
//    this.ustream, this.usemester, this.umarks, this.uchapter, this.udiagram});
//
//  @override
//  _HomeState createState() => _HomeState();
//}
//
//class _HomeState extends State<Home> {
//  final multiSelectKey = GlobalKey<MultiSelectDropdownState>();
//  final _auth = AuthService();
//  final _database = DatabaseHandler();
//  var results;
//  final _formkey = GlobalKey<FormState>();
//  var menuItems = [2014, 2015, 2016, 2017, 2018, 2019,2020];
//  String _yearOfRepeat;
//  final List<String> semesters = ['1','2','3','4','5','6','7','8'];
//  final List<String> marks = ['1','2','3','4','5','6','7','8'];
//  final List<String> courses = ['computer engineering','BSC','commerce','electronics engineering','civil engineering','electrical engineering'];
//  bool loading= false;
//  String isSuccessfull="";
//  String _currentStream;
//  String _currentsubject;
//  String _currentSemester;
//  String _currentMarks;
//  String _currentchapter;
//  String question;
//  String answer;
//  String diagramlink;
//  String thumbnaillink;
//  File diagram;
//  File thumbnail;
//
//  Future getDiagramImage()async{
//    var diagramImage=await ImagePicker.pickImage(
//      source: ImageSource.gallery,
//      imageQuality: 50,
//    );
//    setState(() {
//      diagram=diagramImage;
//      widget.udiagram=null;
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return loading?Loading():Scaffold(
//      backgroundColor: Colors.pink[50],
//      resizeToAvoidBottomPadding: false,
//      appBar: AppBar(
//        backgroundColor: Colors.pinkAccent,
//        title: Text("Home"),
//        actions: <Widget>[
//          FlatButton.icon(onPressed: (){_auth.signOut();}, icon: Icon(Icons.supervised_user_circle), label: Text("Logout")),
//        ],
//      ),
//      body: SingleChildScrollView(
//        physics: AlwaysScrollableScrollPhysics(),
//        padding: EdgeInsets.only(
//            top: 20.0,
//            bottom: 170.0,
//            left: 20,
//            right: 20
//        ),
//        child: Container(
//          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
//          child: Form(
//              key: _formkey,
//              child:Column(
//                children: <Widget>[
//                  SizedBox(height: 20),
//                  FlutterMultiChipSelect(
//                    key: multiSelectKey,
//                    elements: List.generate(
//                      menuItems.length,
//                          (index) => MultiSelectItem<String>.simple(
//                          actions: [
//                            IconButton(
//                              icon: Icon(Icons.delete),
//                              onPressed: () {
//                                setState(() {
//                                  menuItems.remove(menuItems[index]);
//                                });
//                                print("Delete Call at: " + menuItems[index].toString());
//                              },
//                            )
//                          ],
//                          title:menuItems[index].toString(),
//                          value: menuItems[index].toString()),
//                    ),
//                    label: "Select year(s) where ques. was appeared",
//                    values: [
//                      //widget.uyearOfrepeat!=null?widget.uyearOfrepeat.substring(1,widget.uyearOfrepeat.length-1):null
//                      // Pass Initial value array or leave empty array.
//                    ],
//                  ),
//                  SizedBox(height: 20,),
//                  //question
//                  TextFormField(
//                    initialValue: question??widget.uquestion,
//                    keyboardType: TextInputType.multiline,
//                    minLines: 1,//Normal textInputField will be displayed
//                    maxLines: 5,
//
//                    decoration: textInputDecoration.copyWith(hintText: "Enter Question"),
//                    validator: (val)=>val.isEmpty?"Text Field Empty": null,
//                    onChanged: (val){
//                      setState(() {
//                        question=val;
//                      });
//                    },
//                  ),
//                  SizedBox(height: 20,),
//                  //answer
//                  TextFormField(
//                    initialValue: answer??widget.uanswer,
//                    keyboardType: TextInputType.multiline,
//                    minLines: 5,//Normal textInputField will be displayed
//                    maxLines: 15,
//                    decoration: textInputDecoration.copyWith(hintText: "Enter answer"),
//                    validator: (val)=>val.isEmpty?"Text Field Empty": null,
//                    onChanged: (val){
//                      setState(() {
//                        answer=val;
//
//                      });
//                    },
//                  ),
//                  SizedBox(height: 20,),
//                  //stream
//                  DropdownButtonFormField(
//                    hint: Text("Select stream"),
//                    decoration: textInputDecoration,
//                    value: _currentStream??widget.ustream,
//                    items: courses.map((course){
//                      return DropdownMenuItem(
//                        value: course,
//                        child: Text("$course"),
//                      );
//                    }).toList(),
//                    onChanged: (val)=> setState(()=>_currentStream=val),
//                  ),
//                  SizedBox(height: 20,),
//                  //semester
//                  DropdownButtonFormField(
//                    hint: Text("Select semester"),
//                    decoration: textInputDecoration,
//                    value:_currentSemester??widget.usemester,
//                    items: semesters.map((semester){
//                      return DropdownMenuItem(
//                        value: semester,
//                        child: Text("$semester"),
//                      );
//                    }).toList(),
//                    onChanged: (val)=> setState(()=>_currentSemester=val),
//                  ),
//                  SizedBox(height: 20,),
//                  //subject
//                  widget.usubject==null?StreamBuilder(
//                      stream: DatabaseHandler().getThumbnail(_currentStream??widget.ustream??'computer engineering',_currentSemester??widget.usemester??'6'),
//                      builder: (context, snapshot) {
//                        if(snapshot.hasData){
//                          SubjectThumbnail subjectThumbnail = snapshot.data;
//                          List<dynamic> names=subjectThumbnail.thumbnail.keys.toList();
//                          return DropdownButtonFormField(
//                            isExpanded: true,
//                            hint: Text("Select Subject"),
//                            decoration: textInputDecoration,
//                            value: _currentsubject??widget.usubject,
//                            items: names.map((subject){
//                              return DropdownMenuItem(
//                                value: subject,
//                                child: Text("$subject"),
//                              );
//                            }).toList(),
//                            onChanged: (val)=> setState(()=>_currentsubject=val),
//                          );
//                        }else{
//                          return Text('please select stream and semester first');
//                        }
//                      }
//                  ):TextFormField(
//                    initialValue: _currentsubject??widget.usubject,
//                    decoration: textInputDecoration.copyWith(hintText: "Enter subject"),
//                    validator: (val)=>val.isEmpty?"Text Field Empty": null,
//                    onChanged: (val){
//                      setState(() {
//                        _currentsubject=val;
//
//                      });
//                    },
//                  ),
//                  SizedBox(height: 20,),
//                  //chapter
//                  widget.uchapter==null?StreamBuilder(
//                      stream: DatabaseHandler().getChapterNames(_currentsubject??widget.usubject??'mobile application development'),
//                      builder: (context, snapshot) {
//                        if(snapshot.hasData){
//                          ChapterNames chapterNames = snapshot.data;
//                          List names=chapterNames.chapternames;
//                          return DropdownButtonFormField(
//                            isExpanded: true,
//                            hint: Text("Select Chapter"),
//                            decoration: textInputDecoration,
//                            value: _currentchapter??widget.uchapter,
//                            items: names.map((chapter){
//                              return DropdownMenuItem(
//                                value: chapter,
//                                child: Text("$chapter"),
//                              );
//                            }).toList(),
//                            onChanged: (val)=> setState(()=>_currentchapter=val),
//                          );
//                        }else{
//                          return Text('select subject first');
//                        }
//
//                      }
//                  ):TextFormField(
//                    initialValue: _currentchapter??widget.uchapter,
//                    decoration: textInputDecoration.copyWith(hintText: "Enter chapter"),
//                    validator: (val)=>val.isEmpty?"Text Field Empty": null,
//                    onChanged: (val){
//                      setState(() {
//                        _currentchapter=val;
//
//                      });
//                    },
//                  ),
//                  SizedBox(height: 20,),
//                  //course
//                  DropdownButtonFormField(
//                    autofocus: true,
//                    hint: Text("Select marks"),
//                    decoration: textInputDecoration,
//                    value: _currentMarks??widget.umarks,
//                    items: marks.map((mark){
//                      return DropdownMenuItem(
//                        value: mark,
//                        child: Text("$mark"),
//                      );
//                    }).toList(),
//                    onChanged: (val)=> setState(()=>_currentMarks=val),
//                  ),
//                  SizedBox(height: 20,),
//                  //chapter
//
//                  Center(
//                    child: diagram==null&&widget.udiagram==null?Text('you havent selected Diagram'):UploadImage().enableUpload(diagram,widget.udiagram),
//                  ),
//                  SizedBox(height: 40,),
//                  OutlineButton(
//                    onPressed: getDiagramImage,
//                    child: Text("Choose a diagram if needed"),
//
//                  ),
//                  SizedBox(height: 20,),
//
//                  SizedBox(height: 20,),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      RaisedButton(onPressed: () async {
//                        if(_formkey.currentState.validate()){
//                          print(question);
//                          print(answer);
//                          print(_currentSemester);
//                          print(_currentStream);
//                          print(_currentsubject);
//                          print(_currentchapter);
//                          setState(() {
//                            loading=true;
//                          });
//                          _yearOfRepeat=this.multiSelectKey.currentState.result.toString();
//                          if(diagram!=null){
//                            diagramlink=await UploadImage().uploadImage(question??widget.uquestion,diagram);
//                            // thumbnaillink=await uploadImage(_currentStream+"-"+_currentSemester+"-"+subject,thumbnail);
//                          }
//                          dynamic result=await _database.updateUserData(
//                              question??widget.uquestion,
//                              answer??widget.uanswer,
//                              _currentsubject??widget.usubject,
//                              _currentStream??widget.ustream,
//                              _currentSemester??widget.usemester,
//                              _currentchapter??widget.uchapter,
//                              diagramlink??widget.udiagram,
//                              _yearOfRepeat??widget.uyearOfrepeat,
//                              _currentMarks??widget.umarks);
//                          print('result:${result}');
//                          print("Data entered successfully");
//                          if(result!=null){
//                            setState(() {
//                              loading=false;
//                              isSuccessfull="please enter valid data";
//                            });
//                          }else{
//                            setState(() {
//                              loading=false;
//                              isSuccessfull="Data Entered Successfully";
//                            });
//                          }
//                        }
//
//                      },color: Colors.pink,child:Text("Submit", style: TextStyle(color: Colors.white),)),
//                      RaisedButton(
//                        color: Colors.pink,
//                        onPressed: ()async{
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateData()));
//                        },
//                        child: Text("Update Data",style: TextStyle(color: Colors.white)),
//                      )
//                    ],
//                  ),
//                  SizedBox(height: 20,),
//                  Text(
//                    isSuccessfull,
//                    style: TextStyle(
//                      color: Colors.red,
//                      fontSize: 20,
//                    ),
//                  ),
//                ],
//              )
//          ),
//        ),
//      ),
//    );
//  }
//}
