import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:hew_maii/homePage.dart';

import 'dart:async';

import 'package:hew_maii/model/font_style.dart';

class LoaderPage extends StatefulWidget {
  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  StreamSubscription<DataConnectionStatus> listener;

  predictGender() async {
    DataConnectionStatus status = await checkInternet();
    if (status == DataConnectionStatus.connected) {
      Timer(
          Duration(seconds: 1),
          () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No Internet"),
                content: Text("Check your internet connection."),
              ));
    }
  }

  @override
  void initState() {
    predictGender();
    super.initState();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

  checkInternet() async {
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    print("Last results: ${DataConnectionChecker().lastTryResults}");
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
    await Future.delayed(Duration(seconds: 20));
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg/bg_3.jpg'), fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: Color(0xFFFF6F18),
                          radius: 60.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage(
                                    'assets/ico/restaurant_white.png'),
                                width: 40,
                              ),
                              Text(
                                "หิวมั๊ย",
                                style: TextStyle(
                                    fontSize: 26,
                                    fontFamily: FontStyles().fontFamily,
                                    color: Colors.white),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text("เพลิดเพลินกับการสั่งอาหารในมือคุณ",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: FontStyles().fontFamily,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF6F18)))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
