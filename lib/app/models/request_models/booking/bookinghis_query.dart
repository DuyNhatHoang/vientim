

class BookingHisQuery {
  String unitId;
  int status;
  String from;
  String to;
  String doctorid;

  BookingHisQuery({this.unitId, this.status, this.from, this.to, this.doctorid});

  BookingHisQuery.fromJson(Map<String, dynamic> json) {
    unitId = json['unitId'];
    status = json['status'];
    from = json['from'];
    to = json['to'].cast<String>();
    doctorid = json['doctorid'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if(doctorid != null) data['doctorid'] = doctorid;
    if(to != null) data['to'] = to;
    if(from != null) data['from'] = from;
    if(status != null) data['status'] = status;
    if(unitId != null)  data['unitId'] = unitId;
    return data;
  }
}