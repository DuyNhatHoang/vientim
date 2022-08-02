import 'dart:io';

class SaveImageRequest {
  String resultDate;
  String result;
  String examId;
  List<String> formData;
  File file;

  SaveImageRequest({this.resultDate, this.result, this.examId, this.formData, this.file});

  SaveImageRequest.fromJson(Map<String, dynamic> json) {
    resultDate = json['ResultDate'];
    result = json['Result'];
    examId = json['ExamId'];
    formData = json['FormData'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResultDate'] = resultDate;
    data['Result'] = result;
    data['ExamId'] = examId;
    data['FormData'] = formData;
    return data;
  }
}