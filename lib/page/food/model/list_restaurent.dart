class ListRes {
  String id;
  String name;
  String image;

  ListRes(String id, String name, String image) {
    this.id = id;
    this.name = name;
    this.image = image;
  }

  ListRes.fromJson(Map json)
      : id = json['res_id'],
        name = json['res_name'],
        image = json['res_image'];

  Map toJson() {
    return {'id': id, 'name': name, 'image': image};
  }
}