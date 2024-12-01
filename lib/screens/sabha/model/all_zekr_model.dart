class AllZekrModel {
  List<Data>? data;
  String? message;
  bool? status;

  AllZekrModel({this.data, this.message, this.status});

  AllZekrModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  int? id;
  String? content;
  String? user;

  Data({this.id, this.content, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    user = json['user'];
  }
}
