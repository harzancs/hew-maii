import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/inform/model/list_myorder.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MainInform extends StatefulWidget {
  @override
  _MainInformState createState() => _MainInformState();
}

class _MainInformState extends State<MainInform> {
  var listOrder = new List<ListMyOrder>();

  var logUser;
  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logUser = prefs.getString('myUsername');
      getMyOrderDetail(logUser);
    });

    print(logUser);
  }

  Future<List> getMyOrderDetail(String logUser) async {
    final response =
        await http.post(Server().getAllOrder, body: {"ID_CUS": logUser});
    var datauser = json.decode(response.body);
    print("GET STATUS => " + response.body);
    var txtstatus = "${datauser[0]['status']}";
    if (txtstatus != 'false') {
      Iterable list = json.decode(response.body);
      listOrder = list.map((model) => ListMyOrder.fromJson(model)).toList();
    }
    return datauser;
  }

  @override
  void initState() {
    getLocal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
          backgroundColor: Colors.white,
          title: Text(
            'แจ้งเตือน',
            style: TextStyle(
                fontSize: 24,
                fontFamily: FontStyles().fontFamily,
                color: Color(0xFFFFF6F18)),
          )),
      body: Container(
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * .88,
                      width: MediaQuery.of(context).size.width * .86,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listOrder.length,
                          itemBuilder: (contant, index) {
                            return Card(
                              child: Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  child: Column(children: <Widget>[
                                    Text(index.toString())
                                  ])),
                            );
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
