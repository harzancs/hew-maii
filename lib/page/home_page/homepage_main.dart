import 'package:flutter/material.dart';

class ListHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
          ),
          Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 50,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
          ),
          SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Card(
                child: Column(
                  children: <Widget>[Text("data")],
                ),
              ),
              
            ],
          )),
        ],
      ),
    ));
  }
}
