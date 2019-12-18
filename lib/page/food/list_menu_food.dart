import 'package:flutter/material.dart';
import 'package:hew_maii/model/font_style.dart';
import 'package:hew_maii/model/link_image.dart';
import 'package:hew_maii/page/food/food_main.dart';

class ListMenuFood extends StatefulWidget {
  final DataRes value;
  ListMenuFood({Key key, this.value}) : super(key: key);
  @override
  _ListMenuFoodState createState() => _ListMenuFoodState();
}

class _ListMenuFoodState extends State<ListMenuFood> {
  @override
  void initState() {
    Map map = {
      "IDRESTAURENT": widget.value.id,
      "NAMERESTAURENT": widget.value.nameRes,
      "IMAGERESTAURENT": widget.value.imageRes
    };
    print(map);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg/bg_2.jpg'), fit: BoxFit.cover),
        ),
        child: Center(
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
                        widget.value.nameRes + " ",
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
                    width: MediaQuery.of(context).size.width * 0.87,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            child: Image.network(
                                Link().imageMianRestaurent +
                                    '/' +
                                    widget.value.imageRes,
                                width: 430,
                                height: 90,
                                fit: BoxFit.cover),
                          ),
                          ListView()
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
                Icon(
                  Icons.shopping_cart,
                  color: Color(0xFFFF6F18),
                  size: 30,
                ),
                Text(
                  "3",
                  style: TextStyle(
                      color: Color(0xFFFF6F18),
                      fontFamily: FontStyles().fontFamily,
                      fontSize: 16),
                ),
              ],
            ),
            Text(
              "150THB",
              style: TextStyle(
                  color: Color(0xFFFF6F18),
                  fontFamily: FontStyles().fontFamily,
                  fontSize: 16),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFFFF6F18),
                  child: Text(
                    "ตกลง",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: FontStyles().fontFamily,
                        fontSize: 16),
                  ),
                  onPressed: () {},
                ),
                Container(
                  height: 60.0,
                  width: 5.0,
                ),
              ],
            )
          ],
        ),
        color: Colors.white,
        notchMargin: 8.0,
      ),
    );
  }
}
