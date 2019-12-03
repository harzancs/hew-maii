import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class ListDriverPage extends StatefulWidget {
  @override
  _ListDriverPageState createState() => _ListDriverPageState();
}

class _ListDriverPageState extends State<ListDriverPage> {
  bool _switchOn = false;

  TextStyle textStyleStatus = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.white);

  Widget _widgetStatus(bool _switchOn) {
    if (_switchOn) {
      return Text("ใช้งาน", style: textStyleStatus);
    } else {
      return Text("หยุด", style: textStyleStatus);
    }
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
                          "ส่งอาหาร",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 28,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 115,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white.withOpacity(0.2)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _widgetStatus(_switchOn),
                              Switch(
                                value: _switchOn,
                                onChanged: (bool val) {
                                  setState(() {
                                    _switchOn = val;
                                    print(_switchOn);
                                  });
                                },
                                activeTrackColor: Colors.green,
                                activeColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
              ),
              SingleChildScrollView(
                child: Center(),
              )
            ],
          ),
        )),
      ),
    );
  }
}
