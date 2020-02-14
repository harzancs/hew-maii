import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class MainInform extends StatefulWidget {
  @override
  _MainInformState createState() => _MainInformState();
}

class _MainInformState extends State<MainInform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            'แจ้งเตือน',
            style: TextStyle(
                fontSize: 24,
                fontFamily: FontStyles().fontFamily,
                color: Color(0xFFFFF6F18)),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(5)),
                  Text("data")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
