import 'dart:ffi';

class ListFood {
  String id;
  String name;
  String image;
  String price;

  ListFood(String id, String name, String image) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.price = price;
  }

  ListFood.fromJson(Map json)
      : id = json['food_id'],
        name = json['food_name'],
        image = json['food_image'],
        price = json['food_price'];

  Map toJson() {
    return {'id': id, 'name': name, 'image': image, 'price': price};
  }
}
