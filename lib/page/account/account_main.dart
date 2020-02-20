import 'package:flutter/material.dart';
import 'package:hew_maii/homePage.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/account/edit_location.dart';
import 'package:hew_maii/page/account/edit_person.dart';
import 'package:hew_maii/page/account/model/list_custumer.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ListAccountPage extends StatefulWidget {
  @override
  _ListAccountPageState createState() => _ListAccountPageState();
}

class _ListAccountPageState extends State<ListAccountPage> {
  var listPerson = new List<ListPerson>();

  var logUser = '',
      logPass = '',
      logName = '',
      logLastname = '',
      logPhone = '',
      logEmail = '';

  _getUserPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logUser = prefs.getString('myUsername') ?? '';
      logPass = prefs.getString('myPassword') ?? '';
      logName = prefs.getString('myName') ?? '';
      logLastname = prefs.getString('myLastname') ?? '';
      logPhone = prefs.getString('myPhone') ?? '';
      logEmail = prefs.getString('myEmail') ?? '';
    });
  }

  _removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "ออกจากระบบหรือไม่ ?",
            style: TextStyle(
                fontFamily: FontStyles().fontFamily,
                fontSize: 20,
                color: Colors.black),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text(
                "ไม่",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RaisedButton(
              color: Colors.redAccent,
              child: new Text(
                "ใช่",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                _removeData();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getUserPass();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(9),
                          ),
                          Text(
                            "บัญชีของคุณ",
                            style: TextStyle(
                                fontFamily: FontStyles().fontFamily,
                                fontSize: 28,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Card(
                          child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5),
                                ),
                                Icon(
                                  Icons.person,
                                  size: 80,
                                  color: Color(0xFFFF6F18),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Text(
                                              '' +
                                                  logName +
                                                  ' ' +
                                                  logLastname,
                                              overflow: TextOverflow.fade,
                                              style: TextStyle(
                                                  fontFamily:
                                                      FontStyles().fontFamily,
                                                  fontSize: 18),
                                            ))),
                                    Text(
                                      "ID : " + logUser,
                                      style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 14,
                                          color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                              child: new Center(
                                child: new Container(
                                  margin: new EdgeInsetsDirectional.only(
                                      start: 1.0, end: 1.0),
                                  height: 2.0,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  color: Color(0xFFFF6F18),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                        child: Text(
                                          'E-Mail : ' + logEmail,
                                          style: TextStyle(
                                            fontFamily: FontStyles().fontFamily,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(15),
                                    ),
                                    Text('เบอร์โทรศัพท์ : ' + logPhone,
                                        style: TextStyle(
                                          fontFamily: FontStyles().fontFamily,
                                          fontSize: 16,
                                        ))
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      )),
                      Card(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditPerson()),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: Center(
                                  child: Text("แก้ไขข้อมูลส่วนตัว",
                                      style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontSize: 18,
                                      )),
                                ),
                              ))),
                      Card(
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditLocation()),
                                );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height: 50,
                                child: Center(
                                  child: Text("แก้ไขโซนที่อยู่",
                                      style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontSize: 18,
                                      )),
                                ),
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width * 0.9,
                              child: RaisedButton(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(9.0),
                                ),
                                onPressed: () {
                                  _showDialog();
                                },
                                padding: EdgeInsets.all(8.0),
                                color: Colors.redAccent,
                                child: Text(
                                  "ออกจากระบบ (Sign Out)",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: FontStyles().fontFamily,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
