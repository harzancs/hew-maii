import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';

List<String> litems = ["1", "2", "Third", "4"];

class DriverOrder extends StatefulWidget {
  @override
  _DriverOrderState createState() => _DriverOrderState();
}

class _DriverOrderState extends State<DriverOrder> {


  //****************** */
  final TextStyle textHand = new TextStyle(fontFamily: FontStyles().fontFamily,fontSize: 24);
  //****************** */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFFFFF6F18)),
        backgroundColor: Colors.white,
        title: Text(
          ' ',
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
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10)),
                  Card(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .90,
                      child: Column(children: <Widget>[
                        Padding(padding: EdgeInsets.all(5)),
                        Container(
                          width: MediaQuery.of(context).size.width * .85,
                          child: Column(children: <Widget>[
                            Row(children: <Widget>[Text("ผู้สั่ง",style:textHand)]),
                            Divider(),
                            Row(children: <Widget>[Text("ร้านค้า",style:textHand)]),
                          ]),
                        ),
                        Padding(padding: EdgeInsets.all(5)),
                      ]),
                    ),
                  ),
                  Card(
                      child: Container(
                          width: MediaQuery.of(context).size.width * .80,
                          child: Column(children: <Widget>[
                            Padding(padding: EdgeInsets.all(10)),
                            Text("fjsiodjf")
                          ]))),
                ],
              ),
            ),
          )),
    );
  }
}
