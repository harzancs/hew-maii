class ListDriver {
  String order_id;
  String res_name;
  String order_price;

  ListDriver(String order_id, String res_name, String order_price) {
    this.order_id = order_id;
    this.res_name = res_name;
    this.order_price = order_price;
  }

  ListDriver.fromJson(Map json)
      : order_id = json['order_id'],
        res_name = json['res_name'],
        order_price = json['order_price'];
 
  Map toJson() {
    return {
      'order_id': order_id,
      'res_name': res_name,
      'order_price': order_price
    };
  }
}
