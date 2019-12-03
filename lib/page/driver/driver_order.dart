import 'package:flutter/material.dart';

List<String> litems = ["1", "2", "Third", "4"];

class ListOrder extends StatefulWidget {
  @override
  _ListOrderState createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: litems.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
              child: Row(
                children: <Widget>[Text("ด")],
              ),
            );
          },
        ),
      ),
    );
  }
}
