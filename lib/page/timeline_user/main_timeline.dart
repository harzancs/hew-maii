import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/inform/inform_main.dart';
import 'package:hew_maii/page/main_list.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainTimeLine extends StatefulWidget {
  final String idOrder;
  MainTimeLine({Key key, this.idOrder}) : super(key: key);
  @override
  _MainTimeLineState createState() => _MainTimeLineState();
}

class _MainTimeLineState extends State<MainTimeLine> {
  final TextStyle textTitle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  final TextStyle textTitleDetail =
      new TextStyle(fontFamily: FontStyles().fontFamily);
  final TextStyle textDetail = new TextStyle(
      fontFamily: FontStyles().fontFamily, fontWeight: FontWeight.w300);

  String cus_id = '', order_id = '';
  var numStatus = 0;

  //****--********** */
  bool _hideStatus1 = false;
  bool _hideStatus2 = false;
  bool _hideStatus3 = false;
  bool _hideStatus4 = false;
  bool _hideStatus5 = false;
  bool _hideStatus6 = false;
  bool _hideStatus7 = false;
  bool _hideStatus0 = false;
  bool _hideStatus8 = false;
  bool _hideStatusQRcode = false;
  //************ */
  var car_type = '', car_num = '';
  var name_driver = '', lastnum_driver = '';

  @override
  void initState() {
    print("ID ORDER : " + widget.idOrder);
    setState(() {
      order_id = widget.idOrder;
      getMyOrderDetail();
    });

    super.initState();
  }

  Future<List> getMyOrderDetail() async {
    // print(response.body);
    final response = await http
        .post(Server().timeLineOrderStatus, body: {"idOrder": order_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      var txtnumstatus = "${datauser[0]['order_status']}";
      setState(() {
        numStatus = int.parse(txtnumstatus);
        _setStatusDis(numStatus);
        //-----------------------------
        car_type = "${datauser[0]['car_type']}";
        car_num = "${datauser[0]['car_number']}";
        name_driver = "${datauser[0]['cus_name']}";
        lastnum_driver = "${datauser[0]['cus_lastname']}";
      });
    }
    return datauser;
  }

  _setStatusDis(int numStatus) {
    if (numStatus >= 2 || numStatus == 0) {
      setState(() {
        _hideStatus2 = true;
      });
    }
    if (numStatus >= 3 && numStatus < 8) {
      setState(() {
        _hideStatus3 = true;
      });
    }
    if (numStatus >= 4 && numStatus < 8) {
      setState(() {
        _hideStatus4 = true;
      });
    }
    if (numStatus >= 5 && numStatus < 8) {
      setState(() {
        _hideStatus5 = true;
      });
    }
    if (numStatus >= 6 && numStatus < 8) {
      setState(() {
        _hideStatus6 = true;
      });
    }
    if (numStatus >= 7 && numStatus < 8) {
      setState(() {
        _hideStatus7 = true;
      });
    }
    if (numStatus == 0) {
      setState(() {
        _hideStatus0 = true;
      });
    }
    if (numStatus == 6) {
      setState(() {
        _hideStatusQRcode = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
              backgroundColor: Colors.white,
              leading: new IconButton(
                  icon: new Icon(
                    Icons.home,
                    color: Color(0xFFFFF6F18),
                    size: 30,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPageList(),
                      ))),
              title: Text(
                'การดำเนินการ',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: FontStyles().fontFamily,
                    color: Color(0xFFFFF6F18)),
              )),
          body: Container(
            height: 1000,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Column(children: <Widget>[
                    Padding(padding: EdgeInsets.all(10)),
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
                                  Padding(padding: EdgeInsets.all(5)),
                                  Visibility(
                                    visible: true,
                                    child: Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.assignment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ส่งรายการเรียบร้อย",
                                            style: textTitle,
                                          )
                                        ])
                                      ],
                                    ),
                                  ),

                                  //---------------คนขับรถ----
                                  Visibility(
                                    visible: _hideStatus2,
                                    child: Column(children: <Widget>[
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
                                                  "คนขับรถรับรายการ",
                                                  style: textTitle,
                                                ),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "ชื่อ : ",
                                                        style: textTitleDetail,
                                                      ),
                                                      Text(
                                                        "คุณ" +
                                                            name_driver +
                                                            " " +
                                                            lastnum_driver,
                                                        style: textDetail,
                                                      )
                                                    ]),
                                                Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Text(
                                                        "รถ : ",
                                                        style: textTitleDetail,
                                                      ),
                                                      Text(
                                                        "" +
                                                            car_type +
                                                            " " +
                                                            car_num,
                                                        style: textDetail,
                                                      )
                                                    ])
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
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFFFFF6F18),
                                                child: Icon(
                                                  Icons.store,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(children: <Widget>[
                                                Text(
                                                  "ร้านค้ารับรายการและเตรียมอาหาร",
                                                  style: textTitle,
                                                ),
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
                                              Column(children: <Widget>[
                                                Text(
                                                  "ร้านค้าไม่รับรายการ",
                                                  style: textTitle,
                                                ),
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
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFFFFF6F18),
                                                child: Icon(
                                                  Icons.shopping_basket,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(children: <Widget>[
                                                Text(
                                                  "คนขับรับอาหาร",
                                                  style: textTitle,
                                                ),
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
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFFFFF6F18),
                                              child: Icon(
                                                Icons.map,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(children: <Widget>[
                                              Text(
                                                "กำลังจัดส่งอาหาร",
                                                style: textTitle,
                                              ),
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
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundColor:
                                                  Color(0xFFFFF6F18),
                                              child: Icon(
                                                Icons.pin_drop,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(children: <Widget>[
                                              Text(
                                                "ถึงที่หมายของท่าน",
                                                style: textTitle,
                                              )
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
                                      ])),
                                  //---------------เรียบร้อย----
                                  Padding(padding: EdgeInsets.all(5))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _hideStatusQRcode,
                      child: Card(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width * .85,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(5)),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.filter_center_focus,
                                            size: 80,
                                            color: Color(0xFFFFF6F18)),
                                        Text("แสกน QR Code เพื่อรับอาหาร",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily))
                                      ]),
                                  Padding(padding: EdgeInsets.all(5)),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MainInform(),
        ));
  }
}
