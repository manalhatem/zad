class ShareAppModel {
  Data? data;
  bool? status;

  ShareAppModel({this.data,this.status});

  ShareAppModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    status = json['status'];
  }
}

class Data {
  String? appStore;
  String? playStore;

  Data({this.appStore, this.playStore});

  Data.fromJson(Map<String, dynamic> json) {
    appStore = json['app_store'];
    playStore = json['play_store'];
  }
}
