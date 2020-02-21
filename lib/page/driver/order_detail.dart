import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/model/list_orderDetail.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;

class DriverOrderdetail extends StatefulWidget {
  final String idOrder;
  final String price;
  DriverOrderdetail({Key key, this.idOrder, this.price}) : super(key: key);
  @override
  _DriverOrderdetailState createState() => _DriverOrderdetailState();
}

class _DriverOrderdetailState extends State<DriverOrderdetail> {
  var listOrderDetail = new List<DataOrderDetail>();

  final TextStyle textshow = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 18,
      fontWeight: FontWeight.w300);
  final TextStyle texttitle = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 16,
  );
  final TextStyle texttotal = TextStyle(
    fontFamily: FontStyles().fontFamily,
    fontSize: 20,
  );

//************************ */
  Future<List> getStatusNew() async {
    final response = await http.post(Server().getOrderDetailr, body: {
      "order_id": widget.idOrder,
    });
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus = "${datauser[0]['status']}";
    if (txtstatus != "false") {
      setState(() {
        Iterable listFoodOrder = json.decode(response.body);
        listOrderDetail = listFoodOrder
            .map((model) => DataOrderDetail.fromJson(model))
            .toList();
      });
    }

    return datauser;
  }
//************************ */

@override
  void initState() {
    getStatusNew();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "รายการอาหาร OR" + widget.idOrder,
          style: TextStyle(
              fontFamily: FontStyles().fontFamily, color: Color(0xFFFF6F18)),
        ),
      ),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Column(children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(5)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      " รายการ",
                                      style: texttitle,
                                    ),
                                    Text(
                                      "จำนวน",
                                      style: texttitle,
                                    ),
                                  ],
                                ),
                                Divider(color: Color(0xFFFF6F18)),
                                ListView.builder(
                                    itemCount: listOrderDetail.length,
                                    shrinkWrap: true,
                                    itemBuilder: (contant, index) {
                                      return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              listOrderDetail[index].foodName,
                                              style: textshow,
                                            ),
                                            Text(
                                              listOrderDetail[index].foodNum +
                                                  " ",
                                              style: textshow,
                                            ),
                                          ]);
                                    }),
                                Divider(color: Color(0xFFFF6F18)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "ร้านค้าได้รับ",
                                      style: texttotal,
                                    ),
                                    Text(
                                      (int.parse(widget.price) - 30)
                                              .toString() +
                                          " ฿",
                                      style: texttotal,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "รวม",
                                      style: texttotal,
                                    ),
                                    Text(
                                      (int.parse(widget.price)).toString() +
                                          " ฿",
                                      style: texttotal,
                                    )
                                  ],
                                ),
                                Divider(color: Color(0xFFFF6F18)),
                              ],
                            ))
                      ]),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
