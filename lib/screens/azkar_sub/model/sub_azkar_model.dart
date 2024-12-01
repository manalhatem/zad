class SubAzkarModel {
  List<Data>? data;
  String? message;
  bool? status;

  SubAzkarModel({this.data, this.message, this.status});

  SubAzkarModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? name;
  String? image;
  bool? hasChildren;

  Data({this.id, this.name, this.image, this.hasChildren});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    hasChildren = json['has_children'];
  }

}
