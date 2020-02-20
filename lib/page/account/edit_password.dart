import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController controlPass = new TextEditingController();
  TextEditingController controlNewPass = new TextEditingController();
  TextEditingController controlNewPassRe = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final TextStyle _txtstyles =
      TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);
  final TextStyle _txtstylesBT = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 18,
  );

  var password = '', username = '', _newPass = '';
  //----------------------------------------------------
  Future<String> _getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      password = prefs.getString("myPassword");
      username = prefs.getString("myUsername");
    });
  }

  //----------------------------------------------------
  Future<List> updateLocation() async {
    // print(response.body);
    final response = await http.post(Server().updatePassword, body: {
      "cus_id": username,
      "password": controlNewPassRe.text,
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "พบปัญหา โปรติดต่อทางเพจ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status != 'false') {
      _pushLocal();
      Navigator.pop(context);
      setState(() {
        Fluttertoast.showToast(
          msg: "แก้ไข เรียบร้อย",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    }
    return datauser;
  }
  //-**---------------------------------------------------

  @override
  void initState() {
    _getLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "แก้ไขรหัสผ่าน",
          style: TextStyle(
              fontSize: 24,
              fontFamily: FontStyles().fontFamily,
              color: Color(0xFFFFF6F18)),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                updateLocation();
              }
            },
            icon: Icon(
              Icons.save,
              color: Color(0xFFFFF6F18),
              size: 28,
            ),
          )
        ],
      ),
      body: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(5)),
                  Container(
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "รหัสผ่านเดิม",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                          child: TextFormField(
                                            controller: controlPass,
                                            autofocus: false,
                                            obscureText: true,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'กรุณาป้อนข้อมูล';
                                              } else if (val.isNotEmpty) {
                                                if (val != password) {
                                                  return 'รหัสผ่าน ไม่ถูกต้อง';
                                                }
                                              }
                                              return null;
                                            },
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFFF6F18)
                                                  .withOpacity(0.4),
                                              hintText: 'รหัสผ่าน เดิม',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontStyles().fontFamily),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(10)),
                                        Text(
                                          "รหัสผ่านใหม่",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                          child: TextFormField(
                                            controller: controlNewPass,
                                            autofocus: false,
                                            obscureText: true,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'กรุณาป้อนข้อมูล';
                                              } else if (val.isNotEmpty) {
                                                setState(() {
                                                  _newPass = val;
                                                });
                                              }
                                              return null;
                                            },
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                color: Colors.black),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFFF6F18)
                                                  .withOpacity(0.4),
                                              hintText: 'รหัสผ่าน ใหม่',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontStyles().fontFamily),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(3)),
                                        Text(
                                          "รหัสผ่านใหม่ อีกครั้ง",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                            child: TextFormField(
                                                controller: controlNewPassRe,
                                                autofocus: false,
                                                obscureText: true,
                                                keyboardType:
                                                    TextInputType.text,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return 'กรุณาป้อนข้อมูล';
                                                  } else if (val.isNotEmpty) {
                                                    if (val != _newPass) {
                                                      return 'รหัสผ่านใหม่ไม่ตรงกัน';
                                                    }
                                                  }
                                                  return null;
                                                },
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily:
                                                        FontStyles().fontFamily,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Color(0xFFFF6F18)
                                                        .withOpacity(0.4),
                                                    hintText:
                                                        'รหัสผ่าน ใหม่ อีกครั้ง',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)))),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                      ],
                    )),
                  )
                ],
              ),
            ),
          )),
    );
  }

  _pushLocal() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("myPassword", controlNewPassRe.text);
  }
}
