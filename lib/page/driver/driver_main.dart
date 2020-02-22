import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/driver_order.dart';
import 'package:hew_maii/page/driver/driver_timeline.dart';
import 'package:hew_maii/page/driver/model/list_order_driver.dart';
import 'package:hew_maii/page/driver/registor/registor_main.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListDriverPage extends StatefulWidget {
  @override
  _ListDriverPageState createState() => _ListDriverPageState();
}

class _ListDriverPageState extends State<ListDriverPage> {
  bool _switchOn = false;

  var listDriver = new List<ListDriver>();

  TextStyle textStyleStatus = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.white);
  TextStyle textStyleOnOff = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 30, color: Colors.white);
// in Card
  TextStyle textStyleOnTitle = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 30, color: Colors.grey);
  TextStyle textStyleOnUnderTitle = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 16, color: Colors.black);
//-------------------------
  String cus_id = '', idLocation = '';

  bool _hide1 = false;
  bool _hide2 = false;
  bool _hide3 = false;
//-------------------------
  @override
  void initState() {
    _getDataLocal();
    super.initState();
  }

//-------------------------
  _getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cus_id = prefs.getString('myUsername');
      idLocation = prefs.getString('myLocal_id');
      getStatusDrriver();
    });
  }

  //*************** Server
  String orderId = '';
  Future<List> getStatusDrriver() async {
    // print(response.body);
    final response =
        await http.post(Server().driverStatus, body: {"cusId": cus_id});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    if (txtstatus == 'false') {
      setState(() {
        _hide1 = false;
        _hide2 = false;
      });
    } else {
      String status_driver = "${datauser[0]['driver_status']}";
      _hide1 = true;
      _hide2 = true;
      if (status_driver == "0") {
        print(status_driver);
        setState(() {
          _hide3 = false;
          _switchOn = false;
        });
      } else if (status_driver == "1") {
        print(status_driver);
        setState(() {
          _hide3 = false;
          _switchOn = true;
        });
      } else if (status_driver == "2") {
        print(status_driver);
        setState(() {
          orderId = "${datauser[0]['order_id']}";
          _switchOn = true;
          _hide2 = false;
          _hide3 = true;
        });
      }
      _widgetOnOn();
    }
    return datauser;
  }

  Future<List> getStatusNew() async {
    var numStatus;

    if (_switchOn) {
      setState(() {
        numStatus = 1;
      });
    } else if (!_switchOn) {
      setState(() {
        numStatus = 0;
      });
    }

    final response = await http.post(Server().driverUpdateStatus,
        body: {"cusId": cus_id, "numStatus": numStatus.toString()});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    return datauser;
  }

  Future<List> getOrder() async {
    // print(response.body);
    final response = await http.post(Server().driverGetOrder,
        body: {"username": cus_id, "location": idLocation});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status != 'false') {
      print("driver on");
      setState(() {
        print(response.body);
        Iterable list_driver = json.decode(response.body);
        listDriver =
            list_driver.map((model) => ListDriver.fromJson(model)).toList();
      });
    } else {
      print("driver no");
    }
    return datauser;
  }
  //*************** Server

  Widget _widgetStatus(bool _switchOn) {
    if (_switchOn) {
      return Text("ใช้งาน", style: textStyleStatus);
    } else {
      return Text("หยุด", style: textStyleStatus);
    }
  }

  Widget _widgetNoDriver() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(50),
              ),
              Icon(
                Icons.motorcycle,
                color: Colors.white,
                size: 80,
              ),
              Text(
                "สมัครขับส่งอาหาร",
                style: textStyleOnOff,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistorDriver()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.person_add,
                                color: Color(0xFFFFF6F18),
                              ),
                              Text(
                                " ลงทะเบียน",
                                style: TextStyle(
                                    fontFamily: FontStyles().fontFamily,
                                    fontSize: 16,
                                    color: Color(0xFFFFF6F18)),
                              )
                            ]),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _widgetOnOn() {
    if (_switchOn) {
      if (!_hide3) {
        getOrder();
        return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ListView.builder(
              itemCount: listDriver.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (content, index) {
                return Container(
                  child: Card(
                      child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DriverOrder(
                                  orId: listDriver[index].order_id.toString(),
                                  stt: "true",
                                )),
                      );
                    },
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                " OD" + listDriver[index].order_id.toString(),
                                style: textStyleOnTitle,
                              ),
                              Text(
                                listDriver[index].order_price.toString() + "฿ ",
                                style: textStyleOnTitle,
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "  " + listDriver[index].res_name,
                                style: textStyleOnUnderTitle,
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                          )
                        ],
                      ),
                    ),
                  )),
                );
              },
            ));
      } else {
        return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(50),
                  ),
                  Icon(
                    Icons.layers,
                    color: Colors.white,
                    size: 80,
                  ),
                  Text(
                    "กำลังดำเนินการ",
                    style: textStyleOnOff,
                  ),
                  Text(
                    "OR" + orderId,
                    style: textStyleOnOff,
                  ),
                  Card(
                    child: InkWell(
                      onTap: () {
                        var stt = "false";
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DriverTimeline(
                                    orId: orderId,
                                    number: "0",
                                  )),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.format_list_numbered,
                                    color: Color(0xFFFFF6F18),
                                  ),
                                  Text(
                                    " ดูไทม์ไลน์",
                                    style: TextStyle(
                                        fontFamily: FontStyles().fontFamily,
                                        fontSize: 16,
                                        color: Color(0xFFFFF6F18)),
                                  )
                                ]),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
      }
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(50),
                ),
                Icon(
                  Icons.layers_clear,
                  color: Colors.white,
                  size: 80,
                ),
                Text(
                  "ปิดรับงาน",
                  style: textStyleOnOff,
                )
              ],
            ),
          ));
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
                    Visibility(
                        visible: _hide2,
                        child: Row(
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
                                        getStatusNew();
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
                        ))
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: _hide1 ? _widgetOnOn() : _widgetNoDriver(),
                ),
              )
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.8,
              //   width: MediaQuery.of(context).size.width * 0.85,
              //   child: SingleChildScrollView(
              //     child: Column(
              //       children: <Widget>[

              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        )),
      ),
    );
  }
}
