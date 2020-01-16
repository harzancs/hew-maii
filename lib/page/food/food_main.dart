import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/model/link_image.dart';
import 'package:hew_maii/page/food/insert_location.dart';
import 'package:hew_maii/page/food/list_menu_food.dart';
import 'package:hew_maii/page/food/model/list_restaurent.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListFoodPage extends StatefulWidget {
  @override
  _ListFoodPageState createState() => _ListFoodPageState();
}

class API {
  static Future getUsers() {
    return http.get(Server().addressListRestaurent);
  }
}

class DataRes {
  const DataRes({this.id, this.nameRes, this.imageRes});

  final String id, nameRes, imageRes;
}

class _ListFoodPageState extends State<ListFoodPage> {
  var listRes = new List<ListRes>();

  bool _setLocation = false;
  var valueLocal;

  @override
  void initState() {
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

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        print(response.body);
        Iterable list = json.decode(response.body);
        listRes = list.map((model) => ListRes.fromJson(model)).toList();
      });
    });
  }

  Widget listRestaurent() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.76,
      width: MediaQuery.of(context).size.width * 0.87,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: listRes.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
              child: InkWell(
            onTap: () {
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
                      Text(
                        "เปิด ",
                        style: TextStyle(
                            fontFamily: FontStyles().fontFamily,
                            fontSize: 18,
                            color: Color(0xFFF38C61F)),
                      )
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
        child: Center(
            child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
              ),
              Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(9),
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
                        SizedBox(
                            width: 30,
                            child: FloatingActionButton(
                              onPressed: () {},
                              heroTag: "btn1",
                              backgroundColor: Colors.white.withOpacity(0.3),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 20,
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.all(5),
                        ),
                        SizedBox(
                            width: 30,
                            child: FloatingActionButton(
                              onPressed: () {},
                              heroTag: "btn2",
                              backgroundColor: Colors.white.withOpacity(0.3),
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
                      _setLocation ? "ร้านไกล้คุณ : $valueLocal " : "",
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
                  child:
                      _setLocation ? listRestaurent() : insertLocation(context),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
