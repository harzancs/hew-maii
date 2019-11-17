import 'package:flutter/material.dart';

import '../font_style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              // margin: EdgeInsets.only(top: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 1000,
                              height: 300,
                              color: Color(0xFFFF6F18).withOpacity(0.8),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                          size: 50,
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("     "),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "ลงชื่อเข้าใช้งาน",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 26),
                                          ),
                                          Text(
                                            "ลงชื่อเข้าใช้ด้านล่้างเพื่อเพลิดเพลินกับการสั่งอาหารของคุณ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 12),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                          ),
                                          Container(
                                            width: 320,
                                            height: 50,
                                            child: SizedBox(
                                              child: TextField(
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFFFFFFFF),
                                                    fontFamily: FontStyles()
                                                        .fontFamily),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white
                                                        .withOpacity(0.3),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9.0)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.0),
                                                    ),
                                                    hintText: 'Username',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                          ),
                                          Container(
                                            width: 320,
                                            height: 50,
                                            child: SizedBox(
                                              child: TextField(
                                                obscureText: true,
                                                autofocus: false,
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color: Color(0xFFFFFFFF)),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white
                                                        .withOpacity(0.3),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.5)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        9.0)),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9.0),
                                                    ),
                                                    hintText: 'Password',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                            ),
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {},
                                      child: Text("data"),
                                    )
                                  ],
                                ),
                              ),
                            )
                            // Text(
                            //   "data",
                            //   style: TextStyle(
                            //     color: Color(0xFFFF6F18),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
