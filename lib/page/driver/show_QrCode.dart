import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/driver_timeline.dart';
import 'package:hew_maii/server/server.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:http/http.dart' as http;

class ShowQrCode extends StatefulWidget {
  final String idOrder;
  final String idCus;
  ShowQrCode({Key key, this.idOrder, this.idCus}) : super(key: key);
  @override
  _ShowQrCodeState createState() => _ShowQrCodeState();
}

class _ShowQrCodeState extends State<ShowQrCode> {
  final TextStyle textStyletitle = new TextStyle(
      fontFamily: FontStyles().fontFamily,
      color: Color(0xFFFF6F18),
      fontSize: 18);
  final TextStyle textStyledetail =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Color(0xFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "ส่งมอบ : OR" + widget.idOrder,
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
                child: Column(children: <Widget>[
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            QrImage(
                              data: widget.idCus + "," + widget.idOrder,
                            ),
                            Divider(
                              color: Color(0xFFFF6F18),
                              height: 10,
                            ),
                            Text(
                              "สำหรับลูกค้าแสกนรับอาหารและจ่ายเงิน หลังจากนั้นกดปุ่ม ''เรียบร้อย''",
                              style: textStyletitle,
                            ),
                            Padding(padding: EdgeInsets.all(5))
                          ]))
                ]),
              )),
            ])),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 50.0,
              width: 5.0,
            ),
            FlatButton.icon(
              onPressed: () {
                getCheckStatusFinish();
              },
              icon: Icon(
                Icons.motorcycle,
                color: Color(0xFFFF6F18),
              ),
              label: Text(
                "เรียบร้อย",
                style: TextStyle(
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 16,
                    color: Color(0xFFFF6F18)),
              ),
            ),
            Container(
              height: 50.0,
              width: 5.0,
            ),
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }

  Future<List> getCheckStatusFinish() async {
    // print(response.body);
    final response = await http.post(Server().checkFinish,
        body: {"idOrder": widget.idOrder, "idDriver": widget.idCus});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    String txtstatus;
    setState(() {
      txtstatus = "${datauser[0]['status']}";
    });
    if (txtstatus != 'false') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DriverTimeline(
            orId: widget.idOrder,
            number: "7",
          ),
        ),
      );
      setState(() {
        Fluttertoast.showToast(
          msg: "ผู้สั่งแสกน QrCode แล้ว !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DriverTimeline(
            orId: widget.idOrder,
            number: "6",
          ),
        ),
      );
      setState(() {
        Fluttertoast.showToast(
          msg: "ผู้สั่งยังไม่แสกน QrCode แล้ว !!",
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
