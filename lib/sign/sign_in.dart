import 'package:flutter/material.dart';

import '../font_style.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Control Value in TextField
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: 1000,
                height: 380,
                color: Color(0xFFFF6F18).withOpacity(0.8),
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 50,
                          ),
                        )),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 100.0, 0.0, 0.0),
                      child: Text(
                        "ลงชื่อเข้าใช้งาน",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
                      child: Text(
                        "ลงชื่อเข้าใช้งานเพื่อเพลิดเพลินกับการสั่งอาหารของคุณ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(top: 180.0, left: 20.0, right: 20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              child: TextField(
                                controller: username,
                                autofocus: false,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: FontStyles().fontFamily,
                                    color: Color(0xFFFFFFFF)),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(9.0)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0)),
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontStyles().fontFamily)),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(
                              height: 50,
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                autofocus: false,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: FontStyles().fontFamily,
                                    color: Color(0xFFFFFFFF)),
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.3),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Colors.white.withOpacity(0.5)),
                                        borderRadius:
                                            BorderRadius.circular(9.0)),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.white.withOpacity(0)),
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontStyles().fontFamily)),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            ButtonBar(
                              alignment: MainAxisAlignment.end,
                              children: <Widget>[
                                FlatButton(
                              onPressed: () {},
                              child: Text(
                                'ลืมรหัสผ่าน',
                                style: TextStyle(
                                  fontFamily: FontStyles().fontFamily,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              )),
                                RaisedButton(
                                  onPressed: () {
                                    
                                  },
                                  color: Colors.green,
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontSize: 15.0),
                                  ),
                                  textColor: Colors.white,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
