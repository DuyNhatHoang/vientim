class IntervalForDate {
  String from;
  String to;
  int status;
  List<Intervals> intervals;

  IntervalForDate({this.from, this.to, this.status, this.intervals});

  IntervalForDate.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    status = json['status'];
    if (json['intervals'] != null) {
      intervals = <Intervals>[];
      json['intervals'].forEach((v) {
        intervals.add(Intervals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    data['status'] = status;
    if (intervals != null) {
      data['intervals'] = intervals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Intervals {
  String id;
  String from;
  String to;
  int status;
  bool isAvailable;
  int numId;
  int availableQuantity;

  Intervals(
      {this.id,
        this.from,
        this.to,
        this.status,
        this.isAvailable,
        this.numId,
        this.availableQuantity});

  Intervals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    from = json['from'];
    to = json['to'];
    status = json['status'];
    isAvailable = json['isAvailable'];
    numId = json['numId'];
    availableQuantity = json['availableQuantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['from'] = from;
    data['to'] = to;
    data['status'] = status;
    data['isAvailable'] = isAvailable;
    data['numId'] = numId;
    data['availableQuantity'] = availableQuantity;
    return data;
  }
}