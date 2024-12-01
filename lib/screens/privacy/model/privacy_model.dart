class PrivacyModel {
  Data? data;
  String? message;
  bool? status;

  PrivacyModel({this.data, this.message, this.status});

  PrivacyModel.fromJson(Map<dynamic, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

}

class Data {
  String? logo;
  String? privacyPolicy;

  Data({this.logo, this.privacyPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    privacyPolicy = json['privacy_policy'];
  }
}
