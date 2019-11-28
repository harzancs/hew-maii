import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/food/insert_location.dart';

class ListFoodPage extends StatelessWidget {
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
                    SizedBox(
                        width: 30,
                        child: FloatingActionButton(
                          onPressed: () {},
                          heroTag: "btn1",
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 20,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    SizedBox(
                        width: 30,
                        child: FloatingActionButton(
                          onPressed: () {},
                          heroTag: "btn2",
                          backgroundColor: Colors.white.withOpacity(0.3),
                          child: Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 20,
                          ),
                        )),
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
            child: Center(
              child: insertLocation(),
            ),
          )
        ],
      ),
    ));
  }
}
