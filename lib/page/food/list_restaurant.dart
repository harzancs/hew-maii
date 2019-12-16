import 'package:flutter/material.dart';

final List<String> numbers = [
  'ร้านบุ๊คบาร์',
  'บ้านฝน',
  'ครัวคุณโอ๋',
  '@HOME',
  'ร้านอิสลาม'
];

Widget listRestaurent(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.76,
    width: MediaQuery.of(context).size.width * 0.9,
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: numbers.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          child: Container(
            height: 100,
            width: 1000,
            child: Row(
              children: <Widget>[Text(numbers[index].toString())],
            ),
          ),
        );
      },
    ),
  );
}