import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/page/home_page/homepage_main.dart';
import 'package:hew_maii/sign/sign_in.dart';

class MainPageList extends StatefulWidget {
  final DataLogin value;
  MainPageList({Key key, this.value}) : super(key: key);
  @override
  _MainPageListState createState() => _MainPageListState();
}

class _MainPageListState extends State<MainPageList> {
  @override
  void initState() {
    Map map = {
      "USERNAME": widget.value.username,
      "PASSWORD": widget.value.password
    };
    print(map);
    super.initState();
  }

  int selectedIndex = 0;
  final widgetOptions = [
    ListHomePage(),
    Text('Add new beer'),
    Text('Favourites'),
  ];

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
          child: widgetOptions.elementAt(selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              title: Text(
                'หน้าแรก',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), title: Text('New Beer')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(
                'บัญชี',
                style: TextStyle(fontFamily: FontStyles().fontFamily),
              )),
        ],
        currentIndex: selectedIndex,
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
