class MultimediaDetailsModel {
  List<Data>? data;
  String? message;
  bool? status;

  MultimediaDetailsModel({this.data, this.message, this.status});

  MultimediaDetailsModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? desc;
  String? image;
  String? media;
  String? type;
  bool? fav;
  String? favType;

  Data(
      {this.id,
        this.name,
        this.desc,
        this.image,
        this.media,
        this.type,
        this.fav,
        this.favType});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    media = json['media'];
    type = json['type'];
    fav = json['fav'];
    favType = json['fav_type'];
  }

}
