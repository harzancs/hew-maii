import 'dart:convert';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/driver_main.dart';
import 'package:hew_maii/page/driver/driver_order.dart';
import 'package:hew_maii/page/driver/order_detail.dart';
import 'package:hew_maii/page/driver/show_QrCode.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;

class DriverTimeline extends StatefulWidget {
  final String orId;
  final String number;
  DriverTimeline({Key key, this.orId, this.number}) : super(key: key);
  @override
  _DriverTimelineState createState() => _DriverTimelineState();
}

class _DriverTimelineState extends State<DriverTimeline> {
  final TextStyle textTitle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  final TextStyle textTitleDetail =
      new TextStyle(fontFamily: FontStyles().fontFamily);
  final TextStyle textDetail = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontWeight: FontWeight.w300);

  String car_type, car_num, name_driver, lastnum_driver, order_price, driver_id;
  List lt = [];
  var id_driver = '', id_order = '';

  int numStatus;
  bool _hideStatus3 = false,
      _hideStatus4 = false,
      _hideStatus5 = false,
      _hideStatus6 = false,
      _hideStatus7 = false,
      _hideStatus8 = false,
      _hideStatus0 = false,
      _hideReadQRcode = false,
      _hideShowQRcode = false,
      _hideBtSendFood = false,
      _hideBtRount = false,
      _hideBtFinish = false;

  String barcode;
//-------------------------------
  Future<List> getMyOrderDetail() async {
    // print(response.body);
    final response = await http
        .post(Server().timeLineOrderStatus, body: {"idOrder": widget.orId});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      var txtnumstatus = "${datauser[0]['order_status']}";
      setState(() {
        numStatus = int.parse(txtnumstatus);
        _setStatusDis(numStatus);
        // //-----------------------------
        // car_type = "${datauser[0]['car_type']}";
        // car_num = "${datauser[0]['car_number']}";
        // name_driver = "${datauser[0]['cus_name']}";
        // lastnum_driver = "${datauser[0]['cus_lastname']}";
        order_price = "${datauser[0]['order_price']}";
        driver_id = "${datauser[0]['driver_id']}";
      });
    }
    return datauser;
  }

  _setStatusDis(int numStatus) {
    if (numStatus >= 3 && numStatus < 8) {
      setState(() {
        _hideReadQRcode = true;
        _hideStatus3 = true;
      });
    }
    if (numStatus >= 4 && numStatus < 8) {
      setState(() {
        _hideStatus4 = true;
        _hideReadQRcode = false;
        _hideBtSendFood = true;
      });
    }
    if (numStatus >= 5 && numStatus < 8) {
      setState(() {
        _hideStatus5 = true;
        _hideBtSendFood = false;
        _hideBtRount = true;
      });
    }
    if (numStatus >= 6 && numStatus < 8) {
      setState(() {
        _hideStatus6 = true;
        _hideBtRount = false;
        // _hideReadQRcode = true;
      });
    }
    if (numStatus >= 7 && numStatus < 8) {
      setState(() {
        _hideReadQRcode = false;
        _hideStatus7 = true;
        _hideBtFinish = true;
      });
    }
    if (numStatus == 0) {
      setState(() {
        _hideStatus0 = true;
      });
    }
    if (numStatus == 6) {
      setState(() {
        _hideShowQRcode = true;
      });
    }
  }

//------------------------------

  @override
  void initState() {
    getMyOrderDetail();
    super.initState();
    if (widget.number == "7") {
      _setStatusDis(7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          'จัดส่ง OR' + widget.orId,
          style: TextStyle(
              fontSize: 24,
              fontFamily: FontStyles().fontFamily,
              color: Color(0xFFFFF6F18)),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.fastfood,
                size: 26,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverOrderdetail(
                          idOrder: widget.orId, price: order_price)),
                );
              })
        ],
      ),
      body: Container(
        height: 1000,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DriverOrder(
                                orId: widget.orId,
                                stt: "false",
                              )),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .85,
                    child: Column(children: <Widget>[
                      Padding(padding: EdgeInsets.all(5)),
                      Text(
                        "ข้อมูลร้านค้าและผู้สั่ง",
                        style: TextStyle(
                            fontFamily: FontStyles().fontFamily, fontSize: 20),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                    ]),
                  ),
                ),
              ),
              Visibility(
                visible: _hideStatus0,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      getCancelFood();
                    },
                    child: Container(
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Text(
                          "''รับทราบ''",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hideBtSendFood,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      getSendFood();
                    },
                    child: Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Text(
                          "''เดินทางส่งอาหาร''",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hideBtRount,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      getArriveFood();
                    },
                    child: Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Text(
                          "''เดินทางถึงที่หมายแล้ว'",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hideBtFinish,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      pushOrderFinish();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPageList()),
                      );
                    },
                    child: Container(
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Text(
                          "''เรียบร้อย''",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hideReadQRcode,
                child: Card(
                  child: InkWell(
                    onTap: scan,
                    child: Container(
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(5)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.filter_center_focus,
                                    size: 80, color: Color(0xFFFFF6F18)),
                                Text("แสกน QR Code เพื่อรับอาหาร (ร้านอาหาร)",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily))
                              ]),
                          Padding(padding: EdgeInsets.all(5)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _hideShowQRcode,
                child: Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShowQrCode(
                              idOrder: widget.orId, idCus: driver_id),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(5)),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.dashboard,
                                    size: 80, color: Color(0xFFFFF6F18)),
                                Text(
                                    "แสดง QR Code เพื่อมอบอาหารและรับเงิน (ผู้สั่ง)",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily))
                              ]),
                          Padding(padding: EdgeInsets.all(5)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: MediaQuery.of(context).size.width * .85,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * .77,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding: EdgeInsets.all(10)),
                            Visibility(
                              visible: true,
                              child: Column(children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Color(0xFFFFF6F18),
                                      child: Icon(
                                        Icons.motorcycle,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "รับรายการ",
                                            style: textTitle,
                                          ),
                                        ])
                                  ],
                                ),
                              ]),
                            ),
                            //---------------คนขับรถ----
                            //---------------ร้านค้า----
                            Visibility(
                                visible: _hideStatus3,
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.store,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "ร้านค้ารับและเตรียมอาหาร",
                                                style: textTitle,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6,
                                                child: Text(
                                                  "คุณต้องเดินทางไปยังร้านค้าเพื่อรับอาหาร\n*สามารถดูเส้นทางร้านที่ปุ่ม 'ข้อมูลร้านค้าและผู้สั่ง'",
                                                  style: textDetail,
                                                ),
                                              )
                                            ])
                                      ],
                                    ),
                                  ],
                                )),
                            //---------------ร้านค้า----
                            //---------------ยกเลิก ร้านค้า----
                            Visibility(
                                visible: _hideStatus0,
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "ร้านค้าไม่รับรายการ",
                                                style: textTitle,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6,
                                                child: Text(
                                                  "โปรดกดปุ่ม ''รับทราบ'' เพื่อรับออเดอร์อื่นได้",
                                                  style: textDetail,
                                                ),
                                              )
                                            ])
                                      ],
                                    ),
                                  ],
                                )),
                            //---------------ยกเลิก ร้านค้า----
                            //---------------คนขับรับอาหาร----
                            Visibility(
                                visible: _hideStatus4,
                                child: Column(
                                  children: <Widget>[
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.shopping_basket,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "คนขับรับอาหาร",
                                                style: textTitle,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .6,
                                                child: Text(
                                                  "กด 'เดินทางส่งอาหาร' เพื่อเดินทางส่งอาหาร",
                                                  style: textDetail,
                                                ),
                                              )
                                            ])
                                      ],
                                    ),
                                  ],
                                )),
                            //---------------คนขับรับอาหาร----
                            //---------------กำลังส่งอาหาร----
                            Visibility(
                                visible: _hideStatus5,
                                child: Column(children: <Widget>[
                                  Divider(
                                    color: Color(0xFFFFF6F18),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Color(0xFFFFF6F18),
                                        child: Icon(
                                          Icons.map,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "กำลังจัดส่งอาหาร",
                                              style: textTitle,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .6,
                                              child: Text(
                                                "คุณต้องเดินทางไปยังที่อยู่ของผู้สั่งเพื่อส่งมอบอาหาร\n*สามารถดูเส้นทางที่อยู่ผู้สั่งที่ปุ่ม 'ข้อมูลร้านค้าและผู้สั่ง'",
                                                style: textDetail,
                                              ),
                                            )
                                          ])
                                    ],
                                  )
                                ])),
                            //---------------กำลังส่งอาหาร----
                            //---------------ถึงที่หมาย----
                            Visibility(
                                visible: _hideStatus6,
                                child: Column(children: <Widget>[
                                  Divider(
                                    color: Color(0xFFFFF6F18),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundColor: Color(0xFFFFF6F18),
                                        child: Icon(
                                          Icons.pin_drop,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "ถึงที่หมายของท่าน",
                                              style: textTitle,
                                            ),
                                            SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .6,
                                                  child: Row(children: <Widget>[
                                                    Text(
                                                      "กดปุ่ม ",
                                                      style: textDetail,
                                                    ),
                                                    Icon(
                                                      Icons.fastfood,
                                                      color: Color(0xFFFFF6F18),
                                                    ),
                                                    Text(
                                                      " เพื่อทบทวนรายการให้ผู้สั่ง",
                                                      style: textDetail,
                                                    )
                                                  ]),
                                                ))
                                          ])
                                    ],
                                  ),
                                ])),
                            //---------------ถึงที่หมาย----
                            //---------------เรียบร้อย----
                            Visibility(
                              visible: _hideStatus7,
                              child: Column(children: <Widget>[
                                Divider(
                                  color: Color(0xFFFFF6F18),
                                ),
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundColor: Colors.green,
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(children: <Widget>[
                                      Text(
                                        "ได้รับอาหารเรียบร้อยแล้ว",
                                        style: textTitle,
                                      ),
                                    ])
                                  ],
                                ),
                              ]),
                            ),
                            Padding(padding: EdgeInsets.all(10))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(10))
            ]),
          ),
        ),
      ),
    );
  }

  ///--------------//-------------//
  void _showDialogIncorrect() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.close,
              size: 30,
              color: Colors.red,
            ),
            Text(
              " ไม่ถูกต้อง",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 20,
                  color: Colors.black),
            )
          ]),
          content: Text(
              "กรุณาสอบถามข้อมูลอาหารและข้อมูลผู้ส่ง ว่าถูกต้องตามข้อมูลบนไทม์ไลน์นี้หรือไม่",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 16,
                  color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              color: Colors.redAccent,
              child: new Text(
                "ปิด",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogCorrect() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.done_all,
              size: 30,
              color: Colors.green,
            ),
            Text(
              " รับอาหารเรียบร้อย",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 20,
                  color: Colors.black),
            )
          ]),
          content: Text(
              "ค่าอาหารและจ่ายเงินให้ร้าน " +
                  (int.parse(order_price) - 30).toString() +
                  " บาท\n(ไม่รวมค่าส่ง 30 บาท)",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 16,
                  color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              color: Colors.redAccent,
              child: new Text(
                "ปิด",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogSend() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.done_all,
              size: 30,
              color: Colors.green,
            ),
            Text(
              " เดินทางไปส่งอาหาร",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 20,
                  color: Colors.black),
            )
          ]),
          content: Text(
              "ที่อยู่ของผู้สั่ง สามารถดูได้ที่ปุ่ม ''ข้อมูลร้านค้าและผู้สั่ง''",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 16,
                  color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              color: Colors.redAccent,
              child: new Text(
                "ปิด",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogArrive() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.done_all,
              size: 30,
              color: Colors.green,
            ),
            Text(
              " ถึงปลายทาง",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 20,
                  color: Colors.black),
            )
          ]),
          content: Text(
              "ที่อยู่ของผู้สั่งและจุดสังเกตุ สามารถดูได้ที่ปุ่ม ''ข้อมูลร้านค้าและผู้สั่ง''",
              style: TextStyle(
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 16,
                  color: Colors.black)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            RaisedButton(
              color: Colors.redAccent,
              child: new Text(
                "ปิด",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 14,
                    color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //********************************** */
  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        lt = barcode.split(",");
        id_driver = lt[0];
        id_order = lt[1];
        if (driver_id == id_driver && widget.orId == id_order) {
          getReceiveFood(id_driver, id_order);
        } else {
          _showDialogIncorrect();
        }
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        // The user did not grant the camera permission.
      } else {
        // Unknown error.
      }
    } on FormatException {
      // User returned using the "back"-button before scanning anything.
    } catch (e) {
      // Unknown error.
    }
  }

  //************************************ */

  //--------------------------------
  Future<List> pushOrderFinish() async {
    // print(response.body);
    final response =
        await http.post(Server().btFinish, body: {"cus_id": driver_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "เริ่มต้นหา ออเดอร์ใหม่ กันเถอะ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "เจอปัญหา !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    }
    return datauser;
  }

  Future<List> getReceiveFood(String id_driver, String id_order) async {
    // print(response.body);
    final response = await http.post(Server().receiveFoodDriver,
        body: {"idOrder": widget.orId, "idDriver": id_driver});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    if (txtstatus != 'false') {
      _showDialogCorrect();
      setState(() {
        numStatus = 4;
        _setStatusDis(numStatus);
      });
    } else {
      _showDialogIncorrect();
    }
    return datauser;
  }

  Future<List> getSendFood() async {
    // print(response.body);
    final response = await http.post(Server().sendFoodDriver,
        body: {"idOrder": widget.orId, "idDriver": driver_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    if (txtstatus != 'false') {
      _showDialogSend();
      setState(() {
        numStatus = 5;
        _setStatusDis(numStatus);
      });
    }
    return datauser;
  }

  Future<List> getArriveFood() async {
    // print(response.body);
    final response = await http.post(Server().arriveFoodDriver,
        body: {"idOrder": widget.orId, "idDriver": driver_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    if (txtstatus != 'false') {
      _showDialogArrive();
      setState(() {
        numStatus = 6;
        _setStatusDis(numStatus);
      });
    }
    return datauser;
  }

  Future<List> getCancelFood() async {
    // print(response.body);
    final response =
        await http.post(Server().btFinish, body: {"cus_id": driver_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });

    if (txtstatus != 'false') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainPageList()),
      );
      setState(() {
        Fluttertoast.showToast(
          msg: "เริ่มต้นหา ออเดอร์ใหม่ กันเถอะ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "เจอปัญหา !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    }
    return datauser;
  }
}
