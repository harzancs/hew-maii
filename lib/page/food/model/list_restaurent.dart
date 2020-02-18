class ListRes {
  String id;
  String name;
  String image;
  String timeOpen;
  String timeClose;
  String status;
  String local;
  String localMap;

  ListRes(String id, String name, String image, String timeOpen,
      String timeClose, String status, String local) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.timeOpen = timeOpen;
    this.timeClose = timeClose;
    this.status = status;
    this.local = local;
    this.localMap = localMap;
  }

  ListRes.fromJson(Map json)
      : id = json['res_id'],
        name = json['res_name'],
        image = json['res_image'],
        timeOpen = json['res_time_open'],
        timeClose = json['res_time_close'],
        status = json['res_status'],
        local = json['location_id'],
        localMap = json['location_map'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'timeOpen': timeOpen,
      'timeClose': timeClose,
      'status': status,
      'local': local,
      'localMap': localMap
    };
  }
}
