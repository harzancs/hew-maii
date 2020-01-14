class ListRes {
  String id;
  String name;
  String image;
  String timeOpen;
  String timeClose;

  ListRes(
      String id, String name, String image, String timeOpen, String timeClose) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.timeOpen = timeOpen;
    this.timeClose = timeClose;
  }

  ListRes.fromJson(Map json)
      : id = json['res_id'],
        name = json['res_name'],
        image = json['res_image'],
        timeOpen = json['res_time_open'],
        timeClose = json['res_time_close'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'timeOpen': timeOpen,
      'timeClose': timeClose
    };
  }
}
