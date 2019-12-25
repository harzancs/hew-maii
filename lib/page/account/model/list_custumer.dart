class ListPerson {
  String id;
  String name;
  String lastname;
  String phone;
  String email;

  ListPerson(
      String id, String name, String lastname, String phone, String email) {
    this.id = id;
    this.name = name;
    this.lastname = name;
    this.phone = phone;
    this.email = email;
  }

  ListPerson.fromJson(Map json)
      : id = json['cus_id'],
        name = json['cus_name'],
        lastname = json['cus_lastname'],
        phone = json['cus_phone'],
        email = json['cus_email'];

  Map toJson() {
    return {
      'id': id,
      'name': name,
      'lastname': lastname,
      'phone': phone,
      'email': email
    };
  }
}
