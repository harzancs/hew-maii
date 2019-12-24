import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/food/list_menu_food.dart';
import 'package:hew_maii/page/food/model/model_order.dart';

class OrderFood extends StatefulWidget {
  final DataSelectFood value;
  OrderFood({Key key, this.value}) : super(key: key);
  @override
  _OrderFoodState createState() => _OrderFoodState();
}

class _OrderFoodState extends State<OrderFood> {
  var listSelect = new List<ListOrder>();

  final _formKey = GlobalKey<FormState>();

  final TextStyle textshow = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w300);
  final TextStyle texttotal = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  @override
  void initState() {
    List list = widget.value.foodselect;
    listSelect = list.map((model) => ListOrder.fromJson(model)).toList();
    super.initState();
  }

  Widget totalB() {
    int totalBalance = 0;
    for (int i = 0; i < listSelect.length; i++) {
      totalBalance =
          totalBalance + (int.parse(listSelect[i].price) * listSelect[i].count);
    }
    totalBalance = totalBalance + 30;
    return Text(
      totalBalance.toString() + " ฿ ",
      style: texttotal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
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
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 46,
                      ),
                    ),
                    Text(
                      "รายการที่สั่ง ",
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
                child: Form(
                  key: _formKey,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * 0.87,
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  ListView.builder(
                                    itemCount: listSelect.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      int price =
                                          int.parse(listSelect[index].price) *
                                              listSelect[index].count;
                                      return Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  " " +
                                                      listSelect[index]
                                                          .count
                                                          .toString(),
                                                  style: textshow,
                                                ),
                                                Text(
                                                  "  " + listSelect[index].name,
                                                  style: textshow,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              price.toString() + " ฿ ",
                                              style: textshow,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                  Divider(color: Color(0xFFFFF6F18)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(" ค่าจัดส่ง", style: textshow),
                                      Text("30 ฿ ", style: textshow)
                                    ],
                                  ),
                                  Divider(color: Color(0xFFFFF6F18)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(" รวมทั้งหมด", style: texttotal),
                                      totalB()
                                      // Text(totalB() + " ฿ ",
                                      //     style: texttotal)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.87,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    " รายละเอียดในการส่ง",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: FontStyles().fontFamily),
                                  ),
                                  Text(
                                    "   ที่อยู่",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: FontStyles().fontFamily,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                  Text(
                                    "   จุดนัดรับ ที่สังเกตได้ง่าย",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: FontStyles().fontFamily,
                                        color: Color(0xFFFFFFFF)),
                                  ),
                                  Text(
                                    "   เพิ่มเติมถึงผู้ขาย",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextFormField(
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: FontStyles().fontFamily,
                                        color: Color(0xFFFFFFFF)),
                                  )
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 60.0,
              width: 5.0,
            ),
            RaisedButton(
              onPressed: () {},
              color: Color(0xFFFF6F18),
              child: Text(
                "ยืนยันรายการ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 60.0,
              width: 5.0,
            ),
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }
}
