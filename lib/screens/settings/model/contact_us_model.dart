class ContactUsModel {
  Data? data;
  bool? status;

  ContactUsModel({this.data, this.status});

  ContactUsModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
    status = json['status'];
  }
}

class Data {
  String? whatsapp;
  String? website;

  Data({this.whatsapp, this.website});

  Data.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'];
    website = json['website'];
  }
}
