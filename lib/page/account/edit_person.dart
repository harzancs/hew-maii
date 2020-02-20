import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/account/edit_password.dart';
import 'package:hew_maii/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class EditPerson extends StatefulWidget {
  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  TextEditingController controlName = new TextEditingController();
  TextEditingController controlLastname = new TextEditingController();
  TextEditingController controlPhone = new TextEditingController();
  TextEditingController controlEmail = new TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final TextStyle _txtstyles =
      TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);
  final TextStyle _txtstylesBT = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 18,
  );

  var name = '', lastname = '', phone = '', email = '', cus_id = '';
  //----------------------------------------------------
  Future<String> _getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cus_id = prefs.getString("myUsername");
      name = prefs.getString("myName");
      controlName.text = name;
      lastname = prefs.getString("myLastname");
      controlLastname.text = lastname;
      phone = prefs.getString("myPhone");
      controlPhone.text = phone;
      email = prefs.getString("myEmail");
      controlEmail.text = email;
    });
  }

  //----------------------------------------------------
  Future<List> updateLocation() async {
    // print(response.body);
    final response = await http.post(Server().updatePerson, body: {
      "cus_id": cus_id,
      "name": controlName.text,
      "lastname": controlLastname.text,
      "email": controlEmail.text,
      "phone": controlPhone.text
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
  //----------------------------------------------------

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
          "แก้ไขข้อมูลส่วนตัว",
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
                                          "ชื่อ",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                          child: TextFormField(
                                            controller: controlName,
                                            autofocus: false,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'กรุณาป้อนข้อมูล';
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
                                              hintText: 'ชื่อ',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontStyles().fontFamily),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "นามสกุล",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                          child: TextFormField(
                                            controller: controlLastname,
                                            autofocus: false,
                                            validator: (val) {
                                              if (val.isEmpty) {
                                                return 'กรุณาป้อนข้อมูล';
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
                                              hintText: 'นามสกุล',
                                              hintStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily:
                                                      FontStyles().fontFamily),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "เบอร์โทรศัพท์",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                            child: TextFormField(
                                                controller: controlPhone,
                                                maxLength: 10,
                                                autofocus: false,
                                                keyboardType:
                                                    TextInputType.number,
                                                validator: (val) {
                                                  if (val.length != 10) {
                                                    return 'กรุณาป้อนให้ครบ 10 หลัก';
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
                                                    hintText: 'เบอร์โทรศัพท์',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)))),
                                        Text(
                                          "Email",
                                          style: _txtstyles,
                                        ),
                                        SizedBox(
                                            child: TextFormField(
                                                controller: controlEmail,
                                                autofocus: false,
                                                validator: (val) {
                                                  if (val.isEmpty) {
                                                    return 'กรุณาป้อนข้อมูล';
                                                  } else if (!val
                                                      .contains('@')) {
                                                    return 'กรุณาป้อน @ ด้วย';
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontFamily:
                                                        FontStyles().fontFamily,
                                                    color: Colors.black),
                                                decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Color(0xFFFF6F18)
                                                        .withOpacity(0.4),
                                                    hintText: 'email',
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
                        Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditPassword(),
                                  ));
                            },
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "แก้ไขรหัสผ่าน",
                                  style: _txtstylesBT,
                                ),
                              ),
                            ),
                          ),
                        )
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
    prefs.setString("myName",controlName.text);
      prefs.setString("myLastname",controlLastname.text);
      prefs.setString("myPhone",controlPhone.text);
      prefs.setString("myEmail",controlEmail.text);
    
  }
}
