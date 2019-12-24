import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/model/link_image.dart';
import 'package:hew_maii/page/food/food_main.dart';
import 'package:hew_maii/page/food/model/list_food.dart';
import 'package:hew_maii/page/food/order_food.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;

// Future<bool> setStringList(String key, List<String> value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   List<String> myList = (prefs.getStringList('name') ?? List<String>());
//   await prefs.setStringList('name', myList);
// }

// Future<String> getFoodPreference() async {
//   SharedPreferences perfs = await SharedPreferences.getInstance();
//   String name = perfs.getString("name");
//   return name;
// }

class ListMenuFood extends StatefulWidget {
  final DataRes value;
  ListMenuFood({Key key, this.value}) : super(key: key);
  @override
  _ListMenuFoodState createState() => _ListMenuFoodState();
}

class _ListMenuFoodState extends State<ListMenuFood> {
  var listFood = new List<ListFood>();
  Map<String, List> foodSelectMap;

  List listFoodSelect = [];

  Future<List> getFood() async {
    // print(response.body);
    final response = await http
        .post(Server().addressListFood, body: {"ID_RES": widget.value.id});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status != 'false') {
      setState(() {
        print(response.body);
        Iterable list = json.decode(response.body);
        listFood = list.map((model) => ListFood.fromJson(model)).toList();
      });
    } else {}
    return datauser;
  }

  @override
  void initState() {
    Map map = {
      "IDRESTAURENT": widget.value.id,
      "NAMERESTAURENT": widget.value.nameRes,
      "IMAGERESTAURENT": widget.value.imageRes
    };
    print(map);
    super.initState();
    getFood();
  }

  List<int> _counter = List();
  // List<String> _idfood = List();
  // List<String> _pricefood = List();
  int _count = 0;
  int _priceFood = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                      Text(
                        widget.value.nameRes + " ",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: FontStyles().fontFamily,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 7), // changes position of shadow
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.87,
                    // height: MediaQuery.of(context).size.height * 0.76,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            child: Image.network(
                                Link().imageMianRestaurent +
                                    '/' +
                                    widget.value.imageRes,
                                width: 430,
                                height: 90,
                                fit: BoxFit.cover),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.62,
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: listFood.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                if (_counter.length < listFood.length) {
                                  _counter.add(0);
                                  // _namefood.add('');
                                }
                                // for (i = 0; i < listFood.length; i++) {
                                //   _namefood.add(listFood[i].name);
                                //   _pricefood.add(listFood[i].price);
                                // }
                                return Container(
                                  color: Colors.white,
                                  height: 50,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            " " + listFood[index].name,
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 18),
                                          ),
                                          Text(
                                            " [" +
                                                listFood[index]
                                                    .price
                                                    .toString() +
                                                " บาท]",
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 14,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          SizedBox(
                                              width: 50,
                                              height: 40,
                                              child: FlatButton(
                                                shape:
                                                    new RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          90.0),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (_counter[index] > 0) {
                                                      _counter[index]--;
                                                      _count -= 1;
                                                      int priceIni = int.parse(
                                                          listFood[index]
                                                              .price);
                                                      _priceFood =
                                                          _priceFood - priceIni;

                                                      //--------------//
                                                    }
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Color(0xFFFFF6F18),
                                                  size: 22,
                                                ),
                                              )),
                                          Text(
                                            '${_counter[index]}',
                                            style: TextStyle(
                                                fontFamily:
                                                    FontStyles().fontFamily,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                              width: 50,
                                              height: 40,
                                              child: FlatButton(
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      if (_count < 10) {
                                                        _count += 1;
                                                        _counter[index]++;
                                                        int priceIni =
                                                            int.parse(
                                                                listFood[index]
                                                                    .price);
                                                        _priceFood =
                                                            _priceFood +
                                                                priceIni;
                                                      }
                                                    });
                                                  },
                                                  // backgroundColor:
                                                  //     Color(0xFFFFF6F18),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Color(0xFFFFF6F18),
                                                      size: 22,
                                                    ),
                                                  ))),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                //Partitioning Components
                                return new Divider(
                                  color: Color(0xFFFFF6F18),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
                Icon(
                  Icons.shopping_cart,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                Text(
                  "$_count",
                  style: TextStyle(
                      color: Color(0xFFFF6F18),
                      fontFamily: FontStyles().fontFamily,
                      fontSize: 16),
                ),
              ],
            ),
            Text(
              "รวม $_priceFood บาท",
              style: TextStyle(
                  color: Color(0xFFFF6F18),
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 18),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFFFF6F18),
                  child: Text(
                    "ตกลง",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontStyles().fontFamily,
                        fontSize: 16),
                  ),
                  onPressed: () {
                    print(_counter);
                    for (int i = 0; i < listFood.length; i++) {
                      if (_counter[i] != 0) {
                        foodSelectMap["s"] = [
                          {
                            // "name": listFood[i].name,
                            // "price": listFood[i].price,
                            // "count": _counter[i]
                            "name": "na"
                          }
                        ];
                      }
                    }
                    print(foodSelectMap);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => OrderFood(),
                    //     ));
                  },
                ),
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
              ],
            )
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }

  void saveFood() {
    setState(() {});
  }
}
