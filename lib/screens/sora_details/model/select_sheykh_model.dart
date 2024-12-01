class SelectSheykhModel {
  Data? data;
  bool? status;

  SelectSheykhModel({this.data, this.status});

  SelectSheykhModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    status = json['status'];
  }
}

class Data {
  int? id;
  String? name;
  String? server;
  String? singleVerseServer;

  Data({this.id, this.name, this.server, this.singleVerseServer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    server = json['server'];
    singleVerseServer = json['single_verse_server'];
  }
}
