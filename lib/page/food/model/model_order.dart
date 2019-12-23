class ListOrder {
  String id;
  String name;
  String price;
  int count;

  ListOrder(String id, String name, String price, int count) {
    this.id = id;
    this.name = name;
    this.price = price;
    this.count = count;
  }

  ListOrder.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        count = json['count'];

  Map toJson() {
    return {'id': id, 'name': name, 'price': price, 'count': count};
  }
}
