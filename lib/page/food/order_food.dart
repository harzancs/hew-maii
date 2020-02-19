import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/food/list_menu_food.dart';
import 'package:hew_maii/page/food/model/model_order.dart';
import 'package:hew_maii/page/timeline_user/main_timeline.dart';
import 'package:hew_maii/server/server.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderFood extends StatefulWidget {
  final DataSelectFood value;
  OrderFood({Key key, this.value}) : super(key: key);
  @override
  _OrderFoodState createState() => _OrderFoodState();
}

class _OrderFoodState extends State<OrderFood> {
  TextEditingController controlAddress = new TextEditingController();
  TextEditingController controlAddressPoint = new TextEditingController();
  TextEditingController controlOther = new TextEditingController();

  var listSelect = new List<ListOrder>();
  String _mySelection;

  final _formKey = GlobalKey<FormState>();

  final TextStyle textshow = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w300);
  final TextStyle texttotal = TextStyle(
      fontFamily: FontStyles().fontFamily,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  String id_location;
//**-****************************** */
  @override
  void initState() {
    List list = widget.value.foodselect;
    listSelect = list.map((model) => ListOrder.fromJson(model)).toList();
    print("ปริ้น : ");
    print(jsonEncode(listSelect));
    getLocal();

    super.initState();
  }

//**-****************************** */
  List dataLocation = List(); //edited line
  Future<List> getLocation(String id_location) async {
    // print(response.body);
    final response = await http
        .post(Server().selectLocationPlace, body: {"idLocation": id_location});
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    if (status != 'false') {
      setState(() {
        dataLocation = datauser;
      });
    }
    return datauser;
  }

  int totalBalanceDB = 0;
  Widget totalB() {
    int totalBalance = 0;
    for (int i = 0; i < listSelect.length; i++) {
      totalBalance =
          totalBalance + (int.parse(listSelect[i].price) * listSelect[i].count);
    }
    totalBalance = totalBalance + 30;
    totalBalanceDB = totalBalance;
    return Text(
      totalBalance.toString() + " ฿ ",
      style: texttotal,
    );
  }

  var logUser = '';
  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logUser = prefs.getString('myUsername');
    id_location = prefs.getString('myLocal_id');
    getLocation(id_location);
    print(logUser);
  }

  Future<List> confirmOrder() async {
    // print(response.body);
    final response = await http.post(Server().billOrder, body: {
      "username": logUser,
      "res_id": listSelect[0].idRes,
      "order_price": totalBalanceDB.toString(),
      "order_location": _mySelection,
      "order_point": controlAddressPoint.text,
      "order_other": controlOther.text,
      "list_order": jsonEncode(listSelect)
      //"list_order": listSelect
    });
    Map map = {
      "username": logUser,
      "res_id": listSelect[0].idRes,
      "order_price": totalBalanceDB.toString(),
      "order_location": _mySelection,
      "order_point": controlAddressPoint.text,
      "order_other": controlOther.text,
      "list_order": jsonEncode(listSelect)
    };
    print(map);
    var datauser = json.decode(response.body);
    print(response.body);
    var status = "${datauser[0]['status']}";
    var idOrder = "${datauser[0]['idOrder']}";
    if (status == 'false') {
      setState(() {
        Fluttertoast.showToast(
          msg: "บันทึกไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.white,
          textColor: Colors.orange,
          fontSize: 16.0,
        );
      });
    } else if (status != 'false') {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MainTimeLine(idOrder: idOrder.toString()),
          ));
      setState(() {
        Fluttertoast.showToast(
          msg: "รอรับอาหารได้เลย !!!",
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
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          'รายการที่สั่ง',
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
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6),
              ),
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: Column(
                        children: <Widget>[
                          Card(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(5)),
                                      ListView.builder(
                                        itemCount: listSelect.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          int price = int.parse(
                                                  listSelect[index].price) *
                                              listSelect[index].count;
                                          return Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      " " +
                                                          listSelect[index]
                                                              .count
                                                              .toString(),
                                                      style: textshow,
                                                    ),
                                                    Text(
                                                      "  " +
                                                          listSelect[index]
                                                              .name,
                                                      style: textshow,
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  price.toString() + " ฿ ",
                                                  style: textshow,
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      Divider(color: Color(0xFFFFF6F18)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(" ค่าจัดส่ง", style: textshow),
                                          Text("30 ฿ ", style: textshow)
                                        ],
                                      ),
                                      Divider(color: Color(0xFFFFF6F18)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(" รวมทั้งหมด", style: texttotal),
                                          totalB()
                                          // Text(totalB() + " ฿ ",
                                          //     style: texttotal)
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                      )
                                    ],
                                  ))),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                          Card(
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        " รายละเอียดในการส่ง",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily:
                                                FontStyles().fontFamily),
                                      ),
                                      Text(
                                        "   ที่อยู่",
                                        style: TextStyle(
                                            fontFamily: FontStyles().fontFamily,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Container(
                                        child: Center(
                                            child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: new DropdownButtonFormField(
                                            items: dataLocation.map((item) {
                                              return new DropdownMenuItem(
                                                child: new Text(
                                                    item['place_name'],
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 15,
                                                        fontFamily: FontStyles()
                                                            .fontFamily)),
                                                value:
                                                    item['place_id'].toString(),
                                              );
                                            }).toList(),
                                            onChanged: (newVal) {
                                              setState(() {
                                                _mySelection = newVal;
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
                                                      BorderRadius.circular(
                                                          9.0)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
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
                                        )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                      ),
                                      Text(
                                        "   จุดนัดรับ ที่สังเกตได้ง่าย",
                                        style: TextStyle(
                                            fontFamily: FontStyles().fontFamily,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Container(
                                          child: Center(
                                              child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                        child: TextFormField(
                                          controller: controlAddressPoint,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFFF6F18)
                                                .withOpacity(0.3),
                                            hintText:
                                                "เช่น ตรงข้ามร้าน ปากซอย หน้าหอ",
                                            hintStyle: TextStyle(fontSize: 16),
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
                                          ),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                              color: Colors.black),
                                        ),
                                      ))),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                      ),
                                      Text(
                                        "   เพิ่มเติมถึงผู้ขาย",
                                        style: TextStyle(
                                            fontFamily: FontStyles().fontFamily,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Container(
                                          child: Center(
                                              child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.80,
                                        child: TextFormField(
                                          controller: controlOther,
                                          maxLines: 3,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Color(0xFFFFF6F18)
                                                .withOpacity(0.3),
                                            hintText:
                                                "เช่น ไม่ใส่ผัก ไม่ใส่หอมใหญ่",
                                            hintStyle: TextStyle(fontSize: 16),
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
                                          ),
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily:
                                                  FontStyles().fontFamily,
                                              color: Colors.black),
                                        ),
                                      ))),
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                      ),
                                    ],
                                  ))),
                          Padding(
                            padding: EdgeInsets.all(10),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 60.0,
              width: 5.0,
            ),
            RaisedButton(
              onPressed: () {
                if (_mySelection != null) {
                  confirmOrder();
                } else {
                  _showDialogAddress();
                }
              },
              color: Color(0xFFFF6F18),
              child: Text(
                "ยืนยันรายการ",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: FontStyles().fontFamily,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 60.0,
              width: 5.0,
            ),
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }

  void _showDialogAddress() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(" ที่อยู่ ",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          content: new Text(
              "กรุณาเลือกที่อยู่ปลายที่ต้องการส่ง !! \nหากไม่มีให้เลือกสถานที่ไกล้เคียง แล้วเพิ่มรายละเอียดที่สังเกตุได้ง่ายต่อการจัดส่ง ",
              style: TextStyle(fontFamily: FontStyles().fontFamily)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ตกลง",
                  style: TextStyle(fontFamily: FontStyles().fontFamily)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
