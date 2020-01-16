import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class AddLocationInCus extends StatefulWidget {
  @override
  _AddLocationInCusState createState() => _AddLocationInCusState();
}

class _AddLocationInCusState extends State<AddLocationInCus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "ระบุตำแหน่ง",
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
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: Column(
                        children: <Widget>[Text("เลือกพื้นที่ของคุณ")],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
