class ListMyOrder {
  String id;
  String time;
  String status;
  String price;

  ListMyOrder(String id, String time, String status, String price) {
    this.id = id;
    this.time = time;
    this.status = status;
    this.price = price;
  }

  ListMyOrder.fromJson(Map json)
      : id = json['order_id'],
        time = json['order_time'],
        status = json['order_status'],
        price = json['order_price'];

  Map toJson() {
    return {"id": id, "time": time, "status": status, "price": price};
  }
}
