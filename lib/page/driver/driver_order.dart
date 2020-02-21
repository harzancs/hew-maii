import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/driver_timeline.dart';
import 'package:hew_maii/page/map/map.dart';
import 'package:hew_maii/server/server.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DriverOrder extends StatefulWidget {
  final String orId;
  final String stt;
  DriverOrder({Key key, this.orId, this.stt}) : super(key: key);
  @override
  _DriverOrderState createState() => _DriverOrderState();
}

class _DriverOrderState extends State<DriverOrder> {
  //****************** */
  bool status_popen = false;
  final TextStyle textHand =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 24);
  final TextStyle textTitle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);
  final TextStyle textDetail = new TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w300);
  //****************** */

  //----------------------------------------------------------
  var res_name = '', res_phone = '', res_local = '';
  var cus_phone = '', order_point = '';
  var place_name = '', place_lt = '';
  Future<List> getOrder() async {
    // print(response.body);
    final response = await http
        .post(Server().getDetailOrderDriver, body: {"order_id": widget.orId});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status != 'false') {
      setState(() {
        res_name = "${datauser[0]['res_name']}";
        res_phone = "${datauser[0]['res_phone']}";
        res_local = "${datauser[0]['location_map']}";
        cus_phone = "${datauser[0]['cus_phone']}";
        order_point = "${datauser[0]['order_point']}";
        place_name = "${datauser[0]['place_name']}";
        place_lt = "${datauser[0]['location_lt']}";
      });
    }
    return datauser;
  }

  //----------------------------------------------------------
  String cus_id = '';
  _getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cus_id = prefs.getString('myUsername');
    });
  }

  //----------------------------------------------------------
  void _showDialogAccept() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.done,
              color: Colors.green,
            ),
            Text(
              "รับออเดอร์นี้เรียบร้อยแล้ว",
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            )
          ]),
          content: new Text(
            "อ่านรายเอียดการรับและจัดส่งให้เรียบร้อย",
            style: TextStyle(fontFamily: FontStyles().fontFamily),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "ปิด",
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverTimeline(
                            orId: widget.orId,number: "0",
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogDis() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Row(children: <Widget>[
            Icon(
              Icons.close,
              color: Colors.red,
            ),
            Text(
              " มีผู้อื่นรับออเดอร์นี้ก่อนแล้ว",
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            )
          ]),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "ปิด",
                style: TextStyle(fontFamily: FontStyles().fontFamily),
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

  //----------------------------------------------------------

  //******************* */
  Future<List> getStatusDrriver() async {
    // print(response.body);
    final response = await http.post(Server().updateAcceptOrder,
        body: {"cusId": cus_id, "orderId": widget.orId});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });

    if (txtstatus == 'false1') {
      _showDialogDis();
    } else if (txtstatus == 'false0') {
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
    } else if (txtstatus == 'true') {
      _showDialogAccept();
    } else {
      setState(() {
        Fluttertoast.showToast(
          msg: "เจอปัญหา !!" + txtstatus,
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

  //******************* */

  @override
  void initState() {
    getOrder();
    _getDataLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          'รายละเอียด OR' + widget.orId,
          style: TextStyle(
              fontSize: 24,
              fontFamily: FontStyles().fontFamily,
              color: Color(0xFFFFF6F18)),
        ),
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
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .90,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Container(
                          width: MediaQuery.of(context).size.width * .85,
                          child: Column(children: <Widget>[
                            Column(children: <Widget>[
                              Row(children: <Widget>[
                                Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color(0xFFFFF6F18),
                                ),
                                Text(" ผู้สั่ง", style: textHand)
                              ]),
                              Row(children: <Widget>[
                                Padding(padding: EdgeInsets.all(20)),
                                Text("โทรศัพท์ : ", style: textTitle),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .43,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        cus_phone,
                                        style: textDetail,
                                      ),
                                    )),
                                IconButton(
                                    icon: Icon(Icons.call,
                                        color: Color(0xFFFFF6F18)),
                                    onPressed: () {
                                      UrlLauncher.launch(
                                          'tel:+66' + cus_phone.substring(1));
                                    })
                              ]),
                              Row(children: <Widget>[
                                Padding(padding: EdgeInsets.all(20)),
                                Text("ที่อยู่ : ", style: textTitle),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        place_name,
                                        style: textDetail,
                                      ),
                                    )),
                                IconButton(
                                    icon: Icon(Icons.pin_drop,
                                        color: Color(0xFFFFF6F18)),
                                    onPressed: () {
                                      openMapsSheet(
                                          context, place_lt, place_name);
                                    })
                              ]),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(20)),
                                    Text("จุดสังเกตุ : ", style: textTitle),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .5,
                                        // height: MediaQuery.of(context).size.height*.1,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: Text(
                                            order_point,
                                            style: textDetail,
                                          ),
                                        ))
                                  ])
                            ]),
                            Divider(
                              color: Color(0xFFFFF6F18),
                            ),
                            Column(children: <Widget>[
                              Row(children: <Widget>[
                                Icon(
                                  Icons.store,
                                  size: 30,
                                  color: Color(0xFFFFF6F18),
                                ),
                                Text(" ร้านค้า", style: textHand)
                              ]),
                              Row(children: <Widget>[
                                Padding(padding: EdgeInsets.all(20)),
                                Text("ชื่อร้าน : ", style: textTitle),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .43,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Text(
                                        res_name,
                                        style: textDetail,
                                      ),
                                    )),
                              ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                        icon: Icon(Icons.call,
                                            color: Color(0xFFFFF6F18)),
                                        onPressed: () {
                                          UrlLauncher.launch('tel:+66' +
                                              res_phone.substring(1));
                                        }),
                                    Padding(padding: EdgeInsets.all(20)),
                                    IconButton(
                                        icon: Icon(Icons.room,
                                            color: Color(0xFFFFF6F18)),
                                        onPressed: () {
                                          openMapsSheet(
                                              context, res_local, res_name);
                                        }),
                                  ]),
                            ]),
                          ]),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                  Visibility(
                    visible: bool.fromEnvironment(widget.stt),
                    child: Card(
                      color: Colors.green,
                      child: InkWell(
                        onTap: () {
                          getStatusDrriver();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .90,
                          child: Column(children: <Widget>[
                            Padding(padding: EdgeInsets.all(5)),
                            Text(
                              "รับออเดอร์นี้",
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
                  )
                ],
              ),
            ),
          )),
    );
  }
}
