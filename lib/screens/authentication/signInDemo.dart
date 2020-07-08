import "package:flutter/material.dart";
class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 110, 0, 0),
                    child: Text(
                      "Hello",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight:FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 190, 0, 0),
                    child: Text(
                      "There",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight:FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(220, 190, 0, 0),
                    child: Text(
                      ".",
                      style: TextStyle(
                        fontSize: 80,
                        fontWeight:FontWeight.bold,
                        color: Colors.amber
                      ),
                    ),
                  )
                ],
              ),
            ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.amber
                        ),
                      ),
                  ),
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.amber
                      ),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 5.0,),
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment(0.0,1.0),
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "New To StudyOverflow?",
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                              ),
                      ),
                            SizedBox(width: 5.0,),
                            InkWell(
                              onTap: (){print("Sign Up clicked");},
                              child: Text(
                                "SignUp.",
                                style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                ),
                              ),
                            )
                          ],
                        ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                      child: InkWell(
                        onTap: (){print("Forgot password clicked");},
                        child: Text(
                          "Forgot Password.",
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40,),
                Container(
                  height: 55,
                  child: GestureDetector(
                    onTap: (){print("Login button clicked");},
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.amberAccent,
                      color: Colors.amber,
                      elevation: 7,
                      child: Center(
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",

                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                //different method for creating same button
                Container(
                  height: 55.0,
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: (){print("facebook button clicked");},
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 3.0,

                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: ImageIcon(
                              AssetImage("assets/facebook.png"),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Center(
                            child: Text(
                                "Login With FaceBook",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Montserrat",
                                ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


