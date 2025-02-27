import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class DataLogin {
  final String username, password, location;
  const DataLogin({this.username, this.password, this.location});
}

class _SignInState extends State<SignIn> {
  bool visible = false;

  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlUsername = new TextEditingController();
  TextEditingController controlPassword = new TextEditingController();

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLogin, body: {
      "username": controlUsername.text,
      "password": controlPassword.text
    });
    var datauser = json.decode(response.body);
    print("DATA FROM DB : " + response.body);
    var status = "${datauser[0]['status']}";
    print("PRINT STATUS : " + status);
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "ไม่พบข้อมูล",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      var textLocation = "${datauser[0]['location_id']}";
      setState(() {
        Fluttertoast.showToast(
          msg: "สวัสดี คุณ${datauser[0]['cus_name']} !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
        _saveUser(controlUsername.text);
        _savePass(controlPassword.text);
        _saveLocal(textLocation,datauser[0]['location_iid'].toString());
        _saveName(datauser[0]['cus_name']);
        _saveLastname(datauser[0]['cus_lastname']);
        _savePhone(datauser[0]['cus_phone']);
        _saveEmail(datauser[0]['cus_email']);
      });
      CircularProgressIndicator();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainPageList(),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: controlUsername,
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
                                  controller: controlPassword,
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
                                      if (_formKey.currentState.validate()) {
                                        login();
                                      }
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

  Future<String> _saveUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myUsername';
    final value = user;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<String> _savePass(String pass) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myPassword';
    final value = pass;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<String> _saveLocal(String local,String local_id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myLocal';
    if (local?.isEmpty ?? true) {
      local = "Null";
      local_id = "Null";
    }
    final value = local;
    prefs.setString(key, value);
    prefs.setString('myLocal_id', local_id);
    print('saved $value');
  }

  Future<String> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myName';
    final value = name;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<String> _saveLastname(String lastname) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myLastname';
    final value = lastname;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<String> _savePhone(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myPhone';
    final value = phone;
    prefs.setString(key, value);
    print('saved $value');
  }

  Future<String> _saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'myEmail';
    final value = email;
    prefs.setString(key, value);
    print('saved $value');
  }
}
