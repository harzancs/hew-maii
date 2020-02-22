import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegistorDriver extends StatefulWidget {
  @override
  _RegistorDriverState createState() => _RegistorDriverState();
}

class _RegistorDriverState extends State<RegistorDriver> {
  final _formKey = GlobalKey<FormState>();
  //-----------------
  TextEditingController controlIdCard = new TextEditingController();
  TextEditingController controlCarType = new TextEditingController();
  TextEditingController controlCarNumber = new TextEditingController();
  //------------------

  final TextStyle _txtstyles =
      TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);

  bool valuecheck = false;
  //---------------
  String cus_id;
  Future<String> _getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cus_id = prefs.getString("myUsername");
    });
  }

  //---------------
  Future<List> pushRegistor() async {
    // print(response.body);
    final response = await http.post(Server().driverRegistor, body: {
      "idCus": cus_id,
      "idCard": controlIdCard.text,
      "carNumber": controlCarNumber.text,
      "carType": controlCarType.text
    });
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "ไม่สามารถลงทะเบียนคนขับส่งอาหารได้ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      });
    } else if (status != 'false') {
      _showDialog();
    }
    return datauser;
  }

  //----------------------------------------------------
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "ยินดีต้อนรับ คนขับรถคนใหม่",
            style: TextStyle(
              fontFamily: FontStyles().fontFamily,
            ),
          ),
          content: new Text(
            "ขอให้ทำงานส่งอาหาร และสนุกกับมัน",
            style: TextStyle(
              fontFamily: FontStyles().fontFamily,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "OK",
                style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainPageList(),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  //---------------
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
          'ลงทะเบียน',
          style: TextStyle(
              fontSize: 24,
              fontFamily: FontStyles().fontFamily,
              color: Color(0xFFFFF6F18)),
        ),
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
                Padding(padding: EdgeInsets.all(10)),
                Card(
                  child: Container(
                      width: MediaQuery.of(context).size.width * .9,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(6)),
                        Form(
                          key: _formKey,
                          child: Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(2)),
                                  Text(
                                    "เลขประจำตัวประชาชน",
                                    style: _txtstyles,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      maxLength: 13,
                                      controller: controlIdCard,
                                      autofocus: false,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'กรุณาป้อนข้อมูล';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: FontStyles().fontFamily,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color(0xFFFF6F18).withOpacity(0.4),
                                        hintText: 'ID Card',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                FontStyles().fontFamily),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "ชนิดรถ - ยี่ห้อรถ",
                                    style: _txtstyles,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller: controlCarType,
                                      autofocus: false,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'กรุณาป้อนข้อมูล';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: FontStyles().fontFamily,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color(0xFFFF6F18).withOpacity(0.4),
                                        hintText: 'ex. มอเตอร์ไซต์ - HONDA',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                FontStyles().fontFamily),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(5)),
                                  Text(
                                    "ป้ายทะเบียนรถ",
                                    style: _txtstyles,
                                  ),
                                  SizedBox(
                                    child: TextFormField(
                                      controller: controlCarNumber,
                                      autofocus: false,
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'กรุณาป้อนข้อมูล';
                                        }
                                        return null;
                                      },
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontFamily: FontStyles().fontFamily,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color(0xFFFF6F18).withOpacity(0.4),
                                        hintText: 'ex. กก 123 พัทลุง',
                                        hintStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily:
                                                FontStyles().fontFamily),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(2)),
                                  Divider(
                                    color: Color(0xFFFF6F18),
                                  ),
                                  Row(children: <Widget>[
                                    Checkbox(
                                      value: valuecheck,
                                      onChanged: (bool value) {
                                        setState(() {
                                          valuecheck = value;
                                        });
                                      },
                                    ),
                                    Text(
                                      "ยอมรับ",
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily),
                                    ),
                                    InkWell(
                                      child: Text(
                                        "ข้อตกลงและเงี่อนไข",
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily:
                                                FontStyles().fontFamily),
                                      ),
                                      onTap: () {
                                        _showDialogAccept();
                                      },
                                    ),
                                    Text(
                                      "นี้",
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily),
                                    ),
                                  ]),
                                  Padding(padding: EdgeInsets.all(2)),
                                ]),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(4)),
                      ])),
                ),
                Visibility(
                  visible: valuecheck,
                  child: Card(
                    color: Colors.green,
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState.validate()) {
                          print(controlCarNumber.text);
                          pushRegistor();
                        }
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          child: InkWell(
                              child: Column(
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(5)),
                              Text(
                                "ลงทะเบียน",
                                style: TextStyle(
                                    fontFamily: FontStyles().fontFamily,
                                    fontSize: 18,
                                    color: Colors.white),
                              ),
                              Padding(padding: EdgeInsets.all(5)),
                            ],
                          ))),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }

//----------------------------------------------------
  void _showDialogAccept() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("ข้อตกลงและเงื่อนไข",
              style: TextStyle(
                fontFamily: FontStyles().fontFamily,
              )),
          content: new Text(
              "1. เลขบัตรประชาชน ทางแอพฯจะเก็บไว้เป็นหลักฐาน เพื่อยืนยันตัวตน\n" +
                  "2. แอพฯจะทำการแสดงข้อมูล(ชนิดรถ - ยี่ห้อรถ , ป้ายทะเบียน)เหล่านี้ ให้กับผู้สั่งอาหารเพื่อแสดงข้อมูลในการรับอาหารจากผู้ส่ง\n" +
                  "3. ผู้ส่งหรือคนขับรถ เมื่อรับออร์เดอร์อาหารแล้ว จะต้องทำตามขั้นตอนตามไทม์ไลน์\n" +
                  "4. รายได้ที่จะได้รับแต่ละออเดอร์ของผู้ส่งหรือคนขับรถ คือ 25 บาท ''5 บาทที่เหลือจะต้องน้ำมาจ่ายค่าธรรมเนียมต่อแอพฯนี้''\n" +
                  "5. หากโทรหาผู้สั่งอาหาร ทางแอพฯจะไม่รับผิดชอบ ค่าโทรทุกกรณี\n" +
                  "6. ในช่วงทดลองแอพฯ หาเกิดอุบัติเหตุ จะไม่รับผิดชอบทุกกรณี ",
              style: TextStyle(
                fontFamily: FontStyles().fontFamily,
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ตกลง",
                  style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
