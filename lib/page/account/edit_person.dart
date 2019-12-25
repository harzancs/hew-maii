import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

class EditPerson extends StatefulWidget {
  @override
  _EditPersonState createState() => _EditPersonState();
}

class _EditPersonState extends State<EditPerson> {
  final TextStyle _txtstyles =
      TextStyle(fontFamily: FontStyles().fontFamily, fontSize: 16);
  final TextStyle _txtstylesBT = TextStyle(
      fontFamily: FontStyles().fontFamily, fontSize: 18,);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
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
                          "แก้ไขข้อมูลส่วนตัว ",
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
                    child: SingleChildScrollView(
                        child: Column(
                      children: <Widget>[
                        Card(
                            child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        " ชื่อ",
                                        style: _txtstyles,
                                      ),
                                      TextFormField(
                                      ),
                                      Text(
                                        " นามสกุล",
                                        style: _txtstyles,
                                      ),
                                      TextFormField(),
                                      Text(
                                        " เบอร์โทรศัพท์",
                                        style: _txtstyles,
                                      ),
                                      TextFormField(),
                                      Text(
                                        " email",
                                        style: _txtstyles,
                                      ),
                                      TextFormField(),
                                    ],
                                  ),
                                ))),
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        Card(
                          child: InkWell(
                            onTap: () {
                              print("object");
                            },
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 40,
                              child: Center(
                                child: Text(
                                  "แก้ไขรหัสผ่าน",
                                  style: _txtstylesBT,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
