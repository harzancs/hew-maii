import 'package:flutter/material.dart';

import 'font_style.dart';
import 'sign/sign_in.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            Container(
              margin: EdgeInsets.only(top: 180),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      onPressed: () {},
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
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Column(
                children: <Widget>[
                  Text("Version 1.0",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontFamily: FontStyles().fontFamily,
                          fontWeight: FontWeight.normal))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
