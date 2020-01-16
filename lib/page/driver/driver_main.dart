import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/model/list_order_driver.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;

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

  Widget _widgetStatus(bool _switchOn) {
    if (_switchOn) {
      return Text("ใช้งาน", style: textStyleStatus);
    } else {
      return Text("หยุด", style: textStyleStatus);
    }
  }

  Widget _widgetOnOff() {
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

  Widget _widgetOnOn() {
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
              height: 100,
              child: Card(
                  child: InkWell(
                onTap: () {},
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
                      )
                    ],
                  ),
                ),
              )),
            );
          },
        ));
  }

  Future<List> getOrder() async {
    // print(response.body);
    final response =
        await http.post(Server().driverGetOrder, body: {"username": 'harzan'});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status != 'false') {
      setState(() {
        print(response.body);
        Iterable list_driver = json.decode(response.body);
        listDriver =
            list_driver.map((model) => ListDriver.fromJson(model)).toList();
      });
    } else {}
    return datauser;
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
                    Row(
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
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Center(
                  child: _switchOn ? _widgetOnOn() : _widgetOnOff(),
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
