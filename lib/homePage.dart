import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign/sign_in.dart';
import 'sign/sign_up.dart';

import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var logUser, logPass;
  @override
  void initState() {
    Timer(Duration(seconds: 1), () => getLogin());

    super.initState();
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logUser = prefs.getString('myUsername') ?? '';
    logPass = prefs.getString('myPassword') ?? '';
    if (logUser?.isNotEmpty ?? true) {
      print(logUser);
      login();
    }
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLogin,
        body: {"username": logUser, "password": logPass});
    var datauser = json.decode(response.body);
    print("DATA FROM DB : " + response.body);
    var status = "${datauser[0]['status']}";
    print("PRINT STATUS : " + status);
    if (status == 'false') {
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "สวัสดี คุณ${datauser[0]['cus_name']} !!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "หิวมั๊ย",
                          style: TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontFamily: FontStyles().fontFamily),
                        ),
                        Text(
                          "HEW-MAII",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: FontStyles().fontFamily),
                        ),
                      ],
                    ),
                  )
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
                          minWidth: 300.0,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(9.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()),
                              );
                            },
                            padding: EdgeInsets.all(8.0),
                            color: Color.fromRGBO(250, 250, 250, 50),
                            child: Text(
                              "ลงชื่อเข้าใช้งาน",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontFamily: FontStyles().fontFamily,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(2),
                        ),
                        ButtonTheme(
                          minWidth: 300.0,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(9.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()),
                              );
                            },
                            padding: EdgeInsets.all(8.0),
                            color: Color.fromRGBO(250, 250, 250, 150),
                            child: Text(
                              "ลงทะเบียน",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: FontStyles().fontFamily,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Text(
                          "Version 1.0",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: FontStyles().fontFamily,
                              fontWeight: FontWeight.normal),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                  )),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 50.0),
            //   child: Column(
            //     children: <Widget>[
            //       Text("Version 1.0",
            //           style: TextStyle(
            //               fontSize: 14,
            //               color: Colors.white,
            //               fontFamily: FontStyles().fontFamily,
            //               fontWeight: FontWeight.normal))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
