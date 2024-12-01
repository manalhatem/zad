class ContributorsModel {
  List<Data>? data;
  String? message;
  bool? status;

  ContributorsModel({this.data, this.message, this.status});

  ContributorsModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? name;
  String? role;
  String? image;

  Data({this.id, this.name, this.role, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    role = json['role'];
    image = json['image'];
  }

}
