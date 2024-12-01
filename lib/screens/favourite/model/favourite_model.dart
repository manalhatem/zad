class FavouriteModel {
  Data? data;
  String? message;
  bool? status;

  FavouriteModel({this.data, this.message, this.status});

  FavouriteModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  List<Media>? media;
  List<Azkar>? azkar;

  Data({this.media, this.azkar});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
    if (json['azkar'] != null) {
      azkar = <Azkar>[];
      json['azkar'].forEach((v) {
        azkar!.add(Azkar.fromJson(v));
      });
    }
  }

}

class Media {
  int? id;
  String? name;
  String? desc;
  String? image;
  String? media;
  String? type;
  bool? fav;
  String? favType;

  Media(
      {this.id,
        this.name,
        this.desc,
        this.image,
        this.media,
        this.type,
        this.fav,
        this.favType});

  Media.fromJson(Map<String, dynamic> json) {
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

class Azkar {
  int? id;
  String? name;
  String? image;
  bool? hasChildren;

  Azkar({this.id, this.name, this.image, this.hasChildren});

  Azkar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    hasChildren = json['has_children'];
  }

}
