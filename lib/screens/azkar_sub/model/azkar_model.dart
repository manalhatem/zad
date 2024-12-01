class AzkarModel {
  Data? data;
  String? message;
  bool? status;

  AzkarModel({this.data, this.message, this.status});

  AzkarModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  List<Azkar>? azkar;
  String? favType;
  bool? fav;

  Data({this.azkar, this.favType, this.fav});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['azkar'] != null) {
      azkar = <Azkar>[];
      json['azkar'].forEach((v) {
        azkar!.add( Azkar.fromJson(v));
      });
    }
    favType = json['fav_type'];
    fav = json['fav'];
  }

}

class Azkar {
  int? id;
  String? text;
  String? subDescription;
  String? category;
  int? count;

  Azkar({this.id, this.text, this.subDescription, this.category, this.count});

  Azkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    subDescription = json['sub_description'];
    category = json['category'];
    count = json['count'];
  }

}
