class AboutAppModel {
  Data? data;
  String? message;
  bool? status;

  AboutAppModel({this.data, this.message, this.status});

  AboutAppModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? logo;
  String? appVerse;
  String? aboutApp;

  Data({this.logo, this.appVerse, this.aboutApp});

  Data.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    appVerse = json['app_verse'];
    aboutApp = json['about_app'];
  }

}
