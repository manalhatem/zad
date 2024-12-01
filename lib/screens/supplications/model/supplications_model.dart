
class SupplicationsModel {
  List<SupplicationData>? data;
  String? message;
  bool? status;

  SupplicationsModel({this.data, this.message, this.status});

  SupplicationsModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <SupplicationData>[];
      json['data'].forEach((v) {
        data!.add(SupplicationData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

}

class SupplicationData {
  int? id;
  String? name;
  String? source;

  SupplicationData({this.id, this.name, this.source});

  SupplicationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    source = json['source'];
  }
}
