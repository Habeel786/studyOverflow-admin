import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testapp/models/datamodel.dart';
import 'package:testapp/models/subjectnamemodel.dart';


class DatabaseHandler{
  String questionid;
  DatabaseHandler({this.questionid});


  final CollectionReference brewCollection = Firestore.instance.collection("brews");
  Future updateUserData(String question,String answer,String subject,String course,String semester,String chapter, String diagram, String yearofrepeat,String marks)async {
    return await brewCollection.document(question+"-"+semester).setData({
      'Question': question,
      'Answer': answer,
      'Course': course,
      'Semester': semester,
      'Subject': subject,
      'Chapter': chapter,
      'Diagram':diagram,
      'YearOfRepeat':yearofrepeat,
      'Marks':marks
    });
  }
  List<Data> _dataListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Data(
        chapter: doc.data['Chapter']??'',
        answer:  doc.data['Answer']??'',
        course:  doc.data['Course']??'',
        question: doc.data['Question']??'',
        semester:  doc.data['Semester']??'',
        subject:  doc.data['Subject']??'',
        diagram: doc.data['Diagram']??'',
        yearofrepeat:doc.data['YearOfRepeat']??'',
        marks: doc.data['Marks']??'',
        thumbnail: doc.data['Thumbnail']??'',
      );
    }).toList();
  }
  Stream<List<Data>> dataAboutQues(String stream, String semester , String chapter,String subject){
    return Firestore.instance.collection('brews').where('Course', isEqualTo: stream)
        .where('Semester', isEqualTo: semester)
        .where("Subject",isEqualTo:subject)
        .where('Chapter',isEqualTo:chapter )
        .snapshots().map(_dataListFromSnapshot);
  }

  Future deleteData(String question,String semester,String diagram)async{
    if(diagram==null||diagram==''){
      await brewCollection.document(question+'-'+semester).delete();
    }else{
      await brewCollection.document(question+'-'+semester).delete();
      final StorageReference strref = FirebaseStorage.instance.ref().child(question);
      return await strref.delete();
    }

  }


  Future getData(String subname) async{
  var firestore = Firestore.instance;
  QuerySnapshot qn = await firestore.collection("brews").where("Subject",isEqualTo: "python").getDocuments();
  return qn.documents;
  }


  Stream<SubjectThumbnail> getThumbnail(String stream, String semester){
    return Firestore.instance.collection('imagecollection').document(stream+'-'+semester).snapshots().map(_subjectThumbnail);
  }
  SubjectThumbnail _subjectThumbnail(DocumentSnapshot snapshot){
    return SubjectThumbnail(thumbnail:snapshot.data['subimg']);
  }
  Stream<ChapterNames> getChapterNames(String subjectname){
    return Firestore.instance.collection('chapternames').document(subjectname).snapshots().map(_chapterNames);
  }

  ChapterNames _chapterNames(DocumentSnapshot snapshot){
    return ChapterNames(chapternames:snapshot.data['chapters']);
  }
}
