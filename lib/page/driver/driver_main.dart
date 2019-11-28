import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class LisDriverPage extends StatelessWidget {
  bool isSwitched = true;

  Widget _statusWorking(bool isSwitched) {
    if (isSwitched) {
      return Text("ใช้งาน");
    } else if(!isSwitched) {
      return Text("หยุด");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    _statusWorking(isSwitched),
                    Switch(
                      value: isSwitched,
                      onChanged: (val) {},
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
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
    ));
  }
}
