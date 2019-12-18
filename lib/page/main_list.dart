import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/driver/driver_main.dart';
import 'package:hew_maii/page/food/food_main.dart';
import 'package:hew_maii/sign/sign_in.dart';

class MainPageList extends StatefulWidget {
  final DataLogin value;
  MainPageList({Key key, this.value}) : super(key: key);
  @override
  _MainPageListState createState() => _MainPageListState();
}

class _MainPageListState extends State<MainPageList> {
  bool setLocation;
  @override
  void initState() {
    if (widget.value.location.isEmpty) {
      setLocation = false;
    } else {
      setLocation = true;
    }
    Map map = {
      "USERNAME": widget.value.username,
      "PASSWORD": widget.value.password,
      "LOCATION": widget.value.location
    };

    print(map);
    super.initState();
  }

  int selectedIndex = 0;
  final widgetOptions = [
    ListFoodPage(),
    ListDriverPage(),
    Text('Favourites'),
  ];

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
          child: widgetOptions.elementAt(selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              title: Text(
                'สั่งอาหาร',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle),
              title: Text(
                'ขับรถ',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'บัญชี',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              )),
        ],
        currentIndex: selectedIndex,
        // selectedItemColor: Colors.amber[800],
        fixedColor: Color(0xFFFF6F18),
        onTap: onItemTapped,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
