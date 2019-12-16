import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/food/insert_location.dart';
import 'package:hew_maii/page/food/list_restaurant.dart';

class ListFoodPage extends StatefulWidget {
  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class _ListFoodPageState extends State<ListFoodPage> {
  bool _setLocation = true;


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
                height: 40,
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
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(9),
                    ),
                    Text(
                      _setLocation ? "ร้านไกล้คุณ : " : "",
                      style: TextStyle(
                          fontFamily: FontStyles().fontFamily,
                          fontSize: 20,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.all(50),
              // ),
              SingleChildScrollView(
                child: Center(
                  child: _setLocation ? listRestaurent(context) : insertLocation(),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
