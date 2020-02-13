import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/main_list.dart';

class MainTimeLine extends StatefulWidget {
  @override
  _MainTimeLineState createState() => _MainTimeLineState();
}

class _MainTimeLineState extends State<MainTimeLine> {
  int _currentStep = 0;

  final TextStyle textTitle =
      new TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: new IconButton(
              icon: new Icon(
                Icons.home,
                color: Color(0xFFFFF6F18),
                size: 30,
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPageList(),
                  ))),
          title: Text(
            'การดำเนินการ',
            style: TextStyle(
                fontSize: 24,
                fontFamily: FontStyles().fontFamily,
                color: Color(0xFFFFF6F18)),
          )),
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
                Padding(padding: EdgeInsets.all(10)),
                Card(
                    child: Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Column(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * .77,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.assignment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ส่งรายการเรียบร้อย",
                                            style: textTitle,
                                          )
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.motorcycle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "คนขับรถรับรายการ",
                                                style: textTitle,
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("ชื่อ : "),
                                                    Text("ฮัรซาน ชัชวาลย์")
                                                  ]),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("รถ : "),
                                                    Text("ฮัรซาน ชัชวาลย์")
                                                  ])
                                            ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.store,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ร้านค้ารับรายการและเตรียมอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.shopping_basket,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "คนขับรับอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.map,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "กำลังจัดส่งอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.pin_drop,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ถึงที่หมายของท่าน",
                                            style: textTitle,
                                          )
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ได้รับอาหารเรียบร้อยแล้ว",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(5))
                                  ]))
                        ]))),
                Card(
                    child: Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Column(children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * .77,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.assignment,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ส่งรายการเรียบร้อย",
                                            style: textTitle,
                                          )
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.motorcycle,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "คนขับรถรับรายการ",
                                                style: textTitle,
                                              ),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("ชื่อ : "),
                                                    Text("ฮัรซาน ชัชวาลย์")
                                                  ]),
                                              Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("รถ : "),
                                                    Text("ฮัรซาน ชัชวาลย์")
                                                  ])
                                            ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.store,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ร้านค้ารับรายการและเตรียมอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.shopping_basket,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "คนขับรับอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.map,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "กำลังจัดส่งอาหาร",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Color(0xFFFFF6F18),
                                          child: Icon(
                                            Icons.pin_drop,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ถึงที่หมายของท่าน",
                                            style: textTitle,
                                          )
                                        ])
                                      ],
                                    ),
                                    Divider(
                                      color: Color(0xFFFFF6F18),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(children: <Widget>[
                                          Text(
                                            "ได้รับอาหารเรียบร้อยแล้ว",
                                            style: textTitle,
                                          ),
                                        ])
                                      ],
                                    ),
                                    Padding(padding: EdgeInsets.all(5))
                                  ]))
                        ])))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
