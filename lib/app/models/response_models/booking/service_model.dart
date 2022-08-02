class ServiceModel {
  String dateCreated;
  String dateUpdated;
  String id;
  String description;
  String name;
  bool isBooking;
  int price;
  String code;
  bool isChoose;

  ServiceModel(
      {this.dateCreated,
        this.dateUpdated,
        this.id,
        this.isBooking,
        this.price = 275000,
        this.code,
        this.description,
        this.name});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    dateCreated = json['dateCreated'];
    code = json['code'];
    dateUpdated = json['dateUpdated'];
    isBooking = json['isBooking'];
    id = json['id'];
    description = json['description'];
    price = json['price'];
    name = json['name'];
    isChoose = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['isBooking'] = isBooking;
    data['id'] = id;
    data['description'] = description;
    data['name'] = name;
    return data;
  }
}