import 'package:firebase_auth/firebase_auth.dart';
class AuthService{
final FirebaseAuth _auth =FirebaseAuth.instance;
String error="";
List errors=[];

Future registerWithEmailAndPassword(String email, String password) async{
try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
      //print(user);
      return user;
}catch(e){
  print(e);
  error=e.toString();
  return null;
}
}
Future signInWithEmailAndPassword(String email, String password) async{
try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user =result.user;
     // print(user);
      return user;
}catch(e){
  print(e);
  String exp=e.toString();
  errors=exp.split(",");
  error=errors[1];
  print(errors[1]);

  return null;
}
}
//Logout user
  Future signOut()async{
  try{
    _auth.signOut();
  }catch(e){
    print(e.toString());
    return null;
  }
  }

Stream<FirebaseUser> get user{
   return _auth.onAuthStateChanged;
}
}