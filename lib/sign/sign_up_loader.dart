import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:hew_maii/homePage.dart';

import 'dart:async';

import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/sign/sign_up_address.dart';

class SignUpLoaderPage extends StatefulWidget {
  @override
  _SignUpLoaderPageState createState() => _SignUpLoaderPageState();
}

class _SignUpLoaderPageState extends State<SignUpLoaderPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpAddress(),
        ),
      );
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
                    Text("...กำลังบันทึกข้อมูล สมาชิกใหม่...",
                        style: TextStyle(
                            fontSize: 12,
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
}
