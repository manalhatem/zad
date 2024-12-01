class NotificationModel {
  List<Data>? data;
  String? message;
  bool? status;

  NotificationModel({this.data, this.message, this.status});

  NotificationModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? title;
  String? time;
  String? type;
  bool? isActive;

  Data({this.id, this.title, this.time, this.type, this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    type = json['type'];
    isActive = json['is_active'];
  }

}
