class FadlElZekrModel {
  List<Data>? data;
  String? message;
  bool? status;

  FadlElZekrModel({this.data, this.message, this.status});

  FadlElZekrModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  int? id;
  String? content;
  String? benefits;

  Data({this.id, this.content, this.benefits});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    benefits = json['benefits'];
  }
}
