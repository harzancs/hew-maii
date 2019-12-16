import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';
import 'package:hew_maii/sign/sign_in.dart';
import 'package:hew_maii/sign/sign_up.dart';

import 'package:http/http.dart' as http;

class SignUpNext extends StatefulWidget {
  final DataText value;
  SignUpNext({Key key, this.value}) : super(key: key);
  @override
  _SignUpNextState createState() => _SignUpNextState();
}

class _SignUpNextState extends State<SignUpNext> {
  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlUsername = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();
  TextEditingController controlRepassword = new TextEditingController();

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressRegister, body: {
      "username": controlUsername.text,
      "password": controlPassword.text,
      "name": widget.value.name,
      "lastname": widget.value.lastname,
      "email": widget.value.email,
      "phone": widget.value.phone
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "Username นี้ ถูกใช้งานแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status == 'true') {
      setState(() {
        Fluttertoast.showToast(
          msg: "ยินดีต้อนรับ คุณ" + widget.value.name + " !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageList(
            value: DataLogin(
                username: controlUsername.text, password: controlPassword.text),
          ),
        ),
      );
    }
    return datauser;
  }

  bool _isLoading = true;

  String pass;

  @override
  void initState() {
    Map map = {
      "NAME": widget.value.name,
      "LASTNAME": widget.value.lastname,
      "EMAIL": widget.value.email,
      "PHONE": widget.value.phone
    };
    print(map);
    super.initState();
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressRegister, body: {
      "username": controlUsername.text,
      "password": controlPassword.text,
      "name": widget.value.name,
      "lastname": widget.value.lastname,
      "email": widget.value.email,
      "phone": widget.value.phone
    });
    var datauser = json.decode(response.body);
    print(response.body);
    String status = '${datauser[0]['status']}';
    print(status);
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "Username ถูกใช้งานแล้ว",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "สวัสดี คุณ !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageList(
            value: DataLogin(
                username: controlUsername.text, password: controlPassword.text),
          ),
        ),
      );
    }
    return datauser;
  }

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
                        "ลงทะเบียน",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 140.0, 0.0, 0.0),
                      child: Text(
                        "ลงทะเบียนเพื่อเพลิดเพลินกับการสั่งอาหารของคุณ",
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                child: TextFormField(
                                  controller: controlUsername,
                                  autofocus: false,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'กรุณาป้อนข้อมูล';
                                    } else if (val.length < 6) {
                                      return 'กรุณาป้อนข้อมูลเกิน 5 ตัวอักษร';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'Username 6 ตัวขึ้นไป',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlPassword,
                                  autofocus: false,
                                  obscureText: true,
                                  validator: (val) {
                                    pass = val;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'Password',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              SizedBox(
                                child: TextFormField(
                                  controller: controlRepassword,
                                  autofocus: false,
                                  obscureText: true,
                                  validator: (val) {
                                    if (val != pass) {
                                      return 'Password ไม่ตรงกัน';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: FontStyles().fontFamily,
                                      color: Color(0xFFFFFFFF)),
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.3),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white
                                                  .withOpacity(0.5)),
                                          borderRadius:
                                              BorderRadius.circular(9.0)),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white.withOpacity(0)),
                                        borderRadius:
                                            BorderRadius.circular(9.0),
                                      ),
                                      hintText: 'Password อีกครั้ง',
                                      hintStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontStyles().fontFamily)),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              ButtonBar(
                                  alignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      onPressed: () {
                                        if (_formKey.currentState.validate()) {
                                          login();
                                        }
                                      },
                                      color: Colors.green,
                                      child: Text(
                                        _isLoading
                                            ? 'กำลังลงทะเบียน..'
                                            : 'ลงทะเบียน',
                                        style: TextStyle(
                                            fontFamily: FontStyles().fontFamily,
                                            fontSize: 15.0),
                                      ),
                                      textColor: Colors.white,
                                    ),
                                  ])

                              // ButtonBar(
                              //   alignment: MainAxisAlignment.end,
                              //   children: <Widget>[
                              //     FloatingActionButton(
                              //       shape: RoundedRectangleBorder(
                              //           side: BorderSide(color: Colors.white),
                              //           borderRadius:
                              //               BorderRadius.circular(30)),
                              //       backgroundColor:
                              //           Colors.white.withOpacity(0.1),
                              //       elevation: 0,
                              //       onPressed: () {
                              //         if (_formKey.currentState.validate()) {}
                              //       },
                              //       child: Icon(Icons.keyboard_arrow_right),
                              //     )
                              //   ],
                              // )
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
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'ID': controlUsername.text,
      'PASSWORD': controlPassword.text,
      "FIRSTNAME": widget.value.name,
      "LASTNAME": widget.value.lastname,
      "EMAIL": widget.value.email,
      "PHONE": widget.value.phone
    };
  }
}
