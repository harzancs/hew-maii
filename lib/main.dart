import 'package:flutter/material.dart';
import 'package:hew_maii/loader/loader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'หิวมั๊ย',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoaderPage(),
    );
  }
}
