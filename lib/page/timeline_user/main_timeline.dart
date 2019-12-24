import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class MainTimeLine extends StatefulWidget {
  @override
  _MainTimeLineState createState() => _MainTimeLineState();
}

class _MainTimeLineState extends State<MainTimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                    Text(
                      "ดำเนินการ ",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: FontStyles().fontFamily,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              SingleChildScrollView(
                child: Column(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
