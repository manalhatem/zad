class AzkarListenModel {
  List<Data>? data;
  String? message;
  bool? status;

  AzkarListenModel({this.data, this.message, this.status});

  AzkarListenModel.fromJson(Map<dynamic, dynamic> json) {
    if (json['العربية'] != null) {
      data = <Data>[];
      json['العربية'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  int? iD;
  String? tITLE;
  String? aUDIOURL;
  String? tEXT;

  Data({this.iD, this.tITLE, this.aUDIOURL, this.tEXT});

  Data.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tITLE = json['TITLE'];
    aUDIOURL = json['AUDIO_URL'];
    tEXT = json['TEXT'];
  }
}
