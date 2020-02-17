import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/model/link_image.dart';
import 'package:hew_maii/page/food/insert_location.dart';
import 'package:hew_maii/page/food/list_menu_food.dart';
import 'package:hew_maii/page/food/model/list_restaurent.dart';
import 'package:hew_maii/page/inform/inform_main.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListFoodPage extends StatefulWidget {
  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class DataRes {
  const DataRes({this.id, this.nameRes, this.imageRes});

  final String id, nameRes, imageRes;
}

class _ListFoodPageState extends State<ListFoodPage> {
  var listRes = new List<ListRes>();

  bool _setLocation = false;
  var valueLocal;
  bool statusBoolRes = false;
  var res_id = '', local_id = '';

  _getDataLocal() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      res_id = prefs.getString('myUsername');
      local_id = prefs.getString('myLocal_id');
    });
  }

  @override
  void initState() {
    _getDataLocal();
    super.initState();
    readLocal();
  }

  readLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'myLocal';
    valueLocal = prefs.getString(key);
    print('read Local : $valueLocal');
    if (valueLocal == 'Null') {
      setState(() {
        _setLocation = false;
      });
    } else {
      setState(() {
        _setLocation = true;
      });
      _getUsers();
    }
  }

  _getUsers() async {
    final response = await http
        .post(Server().addressListRestaurent, body: {"ID_LOCATION": local_id});

    var datauser = json.decode(response.body);
    var status = "${datauser[0]['status']}";
    print(response.body);

    if (status != 'false') {
      setState(() {
        Iterable list = json.decode(response.body);
        listRes = list.map((model) => ListRes.fromJson(model)).toList();
      });
    }
  }

  Widget _statusRes(String numStatus) {
    if (numStatus == '0') {
      return Text("ปิด ",
          style: TextStyle(
              fontFamily: FontStyles().fontFamily,
              fontSize: 18,
              color: Colors.red));
    } else if (numStatus == '1') {
      statusBoolRes = true;
      return Text("เปิด ",
          style: TextStyle(
              fontFamily: FontStyles().fontFamily,
              fontSize: 18,
              color: Color(0xFFF38C61F)));
    }
  }

  Widget listRestaurent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.74,
      width: MediaQuery.of(context).size.width * 0.87,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listRes.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
              child: InkWell(
            onTap: () {
              if (listRes[index].status.toString() == '1') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListMenuFood(
                        value: DataRes(
                            id: listRes[index].id,
                            nameRes: listRes[index].name,
                            imageRes: listRes[index].image),
                      ),
                    ));
              } else {
                setState(() {
                  Fluttertoast.showToast(
                    msg: "ร้าน '" + listRes[index].name + "' ปิดอยู่ !",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.white,
                    textColor: Colors.orange,
                    fontSize: 16.0,
                  );
                });
              }
            },
            child: Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                    child: Image.network(
                        Link().imageMianRestaurent + '' + listRes[index].image,
                        width: 430,
                        height: 90,
                        fit: BoxFit.cover),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ' + listRes[index].name,
                        style: TextStyle(
                            fontFamily: FontStyles().fontFamily, fontSize: 18),
                      ),
                      _statusRes(listRes[index].status.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ',
                        style: TextStyle(
                            fontFamily: FontStyles().fontFamily, fontSize: 18),
                      ),
                      Text(
                        listRes[index].timeOpen.substring(0, 5) +
                            ' น. - ' +
                            listRes[index].timeClose.substring(0, 5) +
                            ' น. ',
                        style: TextStyle(
                          fontFamily: FontStyles().fontFamily,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                            Icon(
                              Icons.local_dining,
                              color: Colors.white,
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            Text(
                              "หิวมั๊ย",
                              style: TextStyle(
                                  fontFamily: FontStyles().fontFamily,
                                  fontSize: 28,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            // SizedBox(
                            //     width: 30,
                            //     child: FloatingActionButton(
                            //       onPressed: () {},
                            //       heroTag: "btn1",
                            //       backgroundColor: Colors.white.withOpacity(0.3),
                            //       child: Icon(
                            //         Icons.search,
                            //         color: Colors.white,
                            //         size: 20,
                            //       ),
                            //     )),
                            Padding(
                              padding: EdgeInsets.all(5),
                            ),
                            SizedBox(
                                width: 30,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MainInform(),
                                        ));
                                  },
                                  heroTag: "btn2",
                                  backgroundColor:
                                      Colors.white.withOpacity(0.3),
                                  child: Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.all(5),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(9),
                        ),
                        Text(
                          _setLocation ? "เขต : $valueLocal " : "",
                          style: TextStyle(
                              fontFamily: FontStyles().fontFamily,
                              fontSize: 20,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(50),
                  // ),
                  SingleChildScrollView(
                    child: Center(
                      child: _setLocation
                          ? listRestaurent()
                          : insertLocation(context),
                    ),
                  )
                ],
              ),
            )),
          )),
    );
  }
}
