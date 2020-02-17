import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/server/server.dart';
import 'package:hew_maii/sign/sign_up_loader_welcome.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpAddress extends StatefulWidget {
  @override
  _SignUpAddressState createState() => _SignUpAddressState();
}

class _SignUpAddressState extends State<SignUpAddress> {
  final _formKey = GlobalKey<FormState>();
  // Control Value in TextField
  TextEditingController controlLocationMain = new TextEditingController();
  TextEditingController controlLocation = new TextEditingController();

  bool _isLoading = true;

  String pass;
  List dataLocation = List(); //edited line
  String _mySelection;

  @override
  void initState() {
    this.getLocationData();
    super.initState();
    _getUsername();
  }

  //**-****************************** */

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

  Future<List> updateLocation(String user, String pass) async {
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeLoaderPage(user: user, pass: pass),
        ),
      );
    }
    return datauser;
  }

  //**-****************************** */

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(
              'ไม่สามารถออกได้ !!',
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            ),
            content: new Text(
              'กรุณาเลือกพื้นที่ปัจจุบันของท่านก่อน',
              style: TextStyle(fontFamily: FontStyles().fontFamily),
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text(
                  'ตกลง',
                  style: TextStyle(fontFamily: FontStyles().fontFamily),
                ),
              )
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomPadding: true,
          body: Container(
            height: 1000,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_1.jpg'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: 1000,
                    color: Color(0xFFFF6F18).withOpacity(0.8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(padding: EdgeInsets.all(15)),
                              Container(
                                child: Text(
                                  "  โซนที่อยู่ปัจจุบัน",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26.0,
                                      fontFamily: FontStyles().fontFamily),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "    เลือกพื้นที่เพื่อเพลิดเพลินกับการสั่งอาหารของคุณ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontFamily: FontStyles().fontFamily),
                                ),
                              ),
                            ]),
                        Padding(padding: EdgeInsets.all(5)),
                        Container(
                            child: Center(
                                child: Container(
                          width: MediaQuery.of(context).size.width * .85,
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: new DropdownButtonFormField(
                                        items: dataLocation.map((item) {
                                          return new DropdownMenuItem(
                                            child: new Text(
                                                item['location_name'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontFamily: FontStyles()
                                                        .fontFamily)),
                                            value:
                                                item['location_id'].toString(),
                                          );
                                        }).toList(),
                                        onChanged: (newVal) {
                                          setState(() {
                                            _mySelection = newVal;
                                          });
                                        },
                                        value: _mySelection,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Colors.white.withOpacity(0.3),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white
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
                                                    FontStyles().fontFamily))),
                                  ),
                                  ButtonBar(
                                      alignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        RaisedButton(
                                          onPressed: () {
                                            print(_mySelection);
                                            _getUsername();
                                          },
                                          color: Colors.green,
                                          child: Text(
                                            _isLoading
                                                ? 'ตกลง'
                                                : 'กำลังลงทะเบียน..',
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 15.0),
                                          ),
                                          textColor: Colors.white,
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    var user = prefs.get('myUsername');
    var pass = prefs.get('myPassword');
    updateLocation(user, pass);
  }
}
