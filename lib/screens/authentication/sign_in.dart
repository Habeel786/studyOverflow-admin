import 'package:flutter/material.dart';
import 'package:testapp/services/auth.dart';
import 'package:testapp/shared/constants.dart';
import 'package:testapp/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey = GlobalKey<FormState>();
  final _auth= AuthService();
  String email= "";
  String password= "";
  String error="";
  bool loading= false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: Text("Sign In to Study Overflow"),
        elevation: 0,
        backgroundColor: Colors.pinkAccent,
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon: Icon(Icons.person), label: Text('Register'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formkey,
            child:Column(
              children: <Widget>[
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Enter Email"),
                  validator: (val)=>val.isEmpty?"Enter Valid Email": null,
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: "Enter Password"),
                  validator: (val)=>val.length<6?"Password Must Be 6 Chars Long": null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password=val;
                    });
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(onPressed: () async {
                  if(_formkey.currentState.validate()) {
                    setState(() {
                      loading=true;
                    });
                    dynamic results = await _auth.signInWithEmailAndPassword(email, password);
                   if(results==null){
                      setState(() {
                        loading=false;
                       error="error occured while login";
                       print(error);
                       //print(_auth.error);
                     });
                    }
                 }
                },color: Colors.pink,child:Text("Sign In", style: TextStyle(color: Colors.white),)),
                SizedBox(height: 20,),
                Text(
                  _auth.error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),

                ),
              ],
            )

        ),
      ),
    );
  }
}
