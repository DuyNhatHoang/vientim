import 'parents/model.dart';

class Global extends Model {
  String mockBaseUrl;
  String apiUrl;
  String apiPath;
  int received;
  int accepted;
  int onTheWay;
  int ready;
  int inProgress;
  int done;
  int failed;

  Global({mockBaseUrl, apiUrl, apiPath});

  Global.fromJson(Map<String, dynamic> json) {
    mockBaseUrl = json['mock_base_url'].toString();
    apiUrl = json['laravel_base_url'].toString();
    apiPath = json['api_path'].toString();
    received = intFromJson(json, 'received');
    accepted = intFromJson(json, 'accepted');
    onTheWay = intFromJson(json, 'on_the_way');
    ready = intFromJson(json, 'ready');
    inProgress = intFromJson(json, 'in_progress');
    done = intFromJson(json, 'done');
    failed = intFromJson(json, 'failed');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mock_base_url'] = mockBaseUrl;
    data['laravel_base_url'] = apiUrl;
    data['api_path'] = apiPath;
    return data;
  }
}
