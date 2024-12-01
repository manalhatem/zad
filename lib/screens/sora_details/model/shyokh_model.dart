class ShyokhModel {
  List<Data>? data;
  bool? status;

  ShyokhModel({this.data, this.status});

  ShyokhModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    status = json['status'];
  }
}

class Data {
  int? id;
  String? name;
  int? reciterId;

  Data({this.id, this.name,this.reciterId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reciterId = json['reciter_id'];
  }
}
