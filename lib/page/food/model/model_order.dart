class ListOrder {
  String idRes;
  String id;
  String name;
  String price;
  int count;

  ListOrder(String idRes, String id, String name, String price, int count) {
    this.idRes = idRes;
    this.id = id;
    this.name = name;
    this.price = price;
    this.count = count;
  }

  ListOrder.fromJson(Map json)
      : idRes = json['idRes'],
        id = json['id'],
        name = json['name'],
        price = json['price'],
        count = json['count'];

  Map toJson() {
    return {
      'idRes': idRes,
      'id': id,
      'name': name,
      'price': price,
      'count': count
    };
  }
}
