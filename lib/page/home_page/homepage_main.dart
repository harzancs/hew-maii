import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class ListHomePage extends StatelessWidget {
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
                      "หิวมั๊ย",
                      style: TextStyle(
                          fontFamily: FontStyles().fontFamily,
                          fontSize: 28,
                          color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(50),
          ),
          SingleChildScrollView(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
                )
              ],
            )),
          )
        ],
      ),
    ));
  }
}
