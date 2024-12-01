class TracksModel {
  List<Data>? data;
  String? message;
  bool? status;

  TracksModel({this.data, this.message, this.status});

  TracksModel.fromJson(Map<dynamic, dynamic> json) {
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
  List<Tracks>? tracks;

  Data({this.id, this.title, this.tracks});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['tracks'] != null) {
      tracks = <Tracks>[];
      json['tracks'].forEach((v) {
        tracks!.add( Tracks.fromJson(v));
      });
    }
  }
}

class Tracks {
  String? title;
  String? type;
  String? id;
  String? voice;
  String? listen;

  Tracks({this.title, this.type, this.id, this.voice, this.listen});

  Tracks.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    id = json['id'];
    voice = json['voice'];
    listen = json['listen'];
  }
}
