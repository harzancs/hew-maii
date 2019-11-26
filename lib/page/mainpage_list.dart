import 'package:flutter/material.dart';
import 'package:hew_maii/page/home_page/homepage_main.dart';
import 'package:hew_maii/sign/sign_in.dart';

class MainPageList extends StatefulWidget {
  final DataLogin value;
  MainPageList({Key key, this.value}) : super(key: key);
  @override
  _MainPageListState createState() => _MainPageListState();
}

class _MainPageListState extends State<MainPageList> {
  TabController controller;

  @override
  void initState() {
    Map map = {
      "USERNAME": widget.value.username,
      "PASSWORD": widget.value.password
    };
    print(map);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: Container(
          height: 1000,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
          ),
          child: Center(
            child: TabBarView(
              children: <Widget>[
                Text("1"),
                Text("2"),
                Text("3")
              ],
              controller: controller,
            ),
          ),
        ),
        bottomNavigationBar: Material(
          color: Colors.blue,
          child: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.favorite),
              ),
              Tab(
                icon: Icon(Icons.add),
              ),
              Tab(
                icon: Icon(Icons.airport_shuttle),
              ),
            ],
            controller: controller,
          ),
        ));
  }
}
