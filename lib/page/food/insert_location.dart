import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/food/add_location.dart';

Widget insertLocation(context) {
  return Container(
    child: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(50),
        ),
        Icon(
          Icons.place,
          color: Colors.white,
          size: 80,
        ),
        Text(
          "กรุณาระบุ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: FontStyles().fontFamily),
        ),
        Text(
          "ตำแหน่งที่อยู่ของคุณ",
          style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: FontStyles().fontFamily),
        ),
        Container(
            width: 140,
            child: Center(
              child: RaisedButton(
                  color: Colors.white.withOpacity(0.8),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(9.0),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddLocationInCus(),
                        ));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.map),
                      Text(
                        " ที่อยู่ของคุณ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: FontStyles().fontFamily),
                      ),
                    ],
                  )),
            ))
      ],
    )),
  );
}
