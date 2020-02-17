import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/page/main_list.dart';

import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/server/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeLoaderPage extends StatefulWidget {
  final String user;
  final String pass;
  WelcomeLoaderPage({Key key, this.user, this.pass}) : super(key: key);
  @override
  _WelcomeLoaderPageState createState() => _WelcomeLoaderPageState();
}

class _WelcomeLoaderPageState extends State<WelcomeLoaderPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      login();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Color(0xFFFF6F18),
                          radius: 60.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'assets/ico/restaurant_white.png'),
                                width: 40,
                              ),
                              Text(
                                "หิวมั๊ย",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontFamily: FontStyles().fontFamily,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("ยินดีต้อนรับ",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: FontStyles().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6F18)))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<List> login() async {
    // print(response.body);
    final response = await http.post(Server().addressLogin,
        body: {"username": widget.user, "password": widget.pass});
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
        _saveUser(widget.user);
        _savePass(widget.pass);
        _saveLocal(textLocation, datauser[0]['location_iid'].toString());
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

  Future<String> _saveLocal(String local, String local_id) async {
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
