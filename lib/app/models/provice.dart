class Provinces {
  List<Province> provinces;

  Provinces({provinces});

  Provinces.fromJson(Map<String, dynamic> json) {
    if (json['provinces'] != null) {
      provinces = <Province>[];
      json['provinces'].forEach((v) {
        provinces.add(Province.fromJson(v));
      });
    }
  }
}

class Province {
  String label;
  String value;
  List<Districts> districts;

  Province({label, value, districts});

  Province.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    if (json['districts'] != null) {
      districts = <Districts>[];
      json['districts'].forEach((v) {
        districts.add(Districts.fromJson(v));
      });
    }
  }
}

class Districts {
  String label;
  String value;
  List<Wards> wards;

  Districts({label, value, wards});

  Districts.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    if (json['wards'] != null) {
      wards = <Wards>[];
      json['wards'].forEach((v) {
        wards.add(Wards.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    if (wards != null) {
      data['wards'] = wards.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wards {
  String label;
  String value;

  Wards({label, value});

  Wards.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}