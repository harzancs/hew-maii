import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditLocation extends StatefulWidget {
  @override
  _EditLocationState createState() => _EditLocationState();
}

class _EditLocationState extends State<EditLocation> {
  String _mySelection;
  List dataLocation = List(); //edited line

  bool _hide = false;
  var user = '', pass = '';

  final TextStyle _txtstyles =
      TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);

  Future<String> _getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _mySelection = prefs.getString("myLocal_id");
      user = prefs.getString("myUsername");
      pass = prefs.getString("myPassword");
    });
  }

  Future<List> updateLocation() async {
    // print(response.body);
    final response = await http.post(Server().updateLocation,
        body: {"username": user, "password": pass, "location": _mySelection});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "พบปัญหา โปรติดต่อทางเพจ !!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status == 'true') {
      _pushLocal(_mySelection);
      Navigator.pop(context);
      setState(() {
        Fluttertoast.showToast(
          msg: "แก้ไข เรียบร้อย",
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

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          "แก้ไขโซนที่อยู่",
          style: TextStyle(
              fontSize: 24,
              fontFamily: FontStyles().fontFamily,
              color: Color(0xFFFFF6F18)),
        ),
        actions: <Widget>[
          Visibility(
            child: IconButton(
              onPressed: () {
                updateLocation();
              },
              icon: Icon(
                Icons.save,
                color: Color(0xFFFFF6F18),
                size: 28,
              ),
            ),
            visible: _hide,
          )
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
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.all(5)),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(10)),
                                Container(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "เลือกโซน",
                                      style: _txtstyles,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: SizedBox(
                                        child: DropdownButtonFormField(
                                          items: dataLocation.map((item) {
                                            return new DropdownMenuItem(
                                              child: new Text(
                                                  item['location_name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontFamily: FontStyles()
                                                          .fontFamily)),
                                              value: item['location_id']
                                                  .toString(),
                                            );
                                          }).toList(),
                                          onChanged: (newVal) {
                                            setState(() {
                                              _mySelection = newVal;
                                              _hide = true;
                                              print(_mySelection);
                                            });
                                          },
                                          value: _mySelection,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFFF6F18)
                                                .withOpacity(0.3),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.orange
                                                        .withOpacity(0.5)),
                                                borderRadius:
                                                    BorderRadius.circular(9.0)),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white
                                                      .withOpacity(0)),
                                              borderRadius:
                                                  BorderRadius.circular(9.0),
                                            ),
                                            hintStyle: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontStyles().fontFamily),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                                Padding(padding: EdgeInsets.all(10)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getLocationData() async {
    var res = await http.get(Uri.encodeFull(Server().getLocationMain),
        headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      dataLocation = resBody;
    });

    print(resBody);

    return "Sucess";
  }

  _pushLocal(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('myLocal_id', value);
    for (int i = 0; i < dataLocation.length; i++) {
      if (dataLocation[i]['location_id'] == value) {
        prefs.setString('myLocal', dataLocation[i]['location_name']);
        print(dataLocation[i]['location_name']);
      }
    }
  }
}
