class OnBoardingModel {
  List<Data>? data;
  String? message;
  bool? status;

  OnBoardingModel({this.data, this.message, this.status});

  OnBoardingModel.fromJson(Map<dynamic, dynamic> json) {
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
  String? imageOne;
  String? imageTwo;

  Data({this.id, this.name, this.desc, this.imageOne, this.imageTwo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    imageOne = json['image_one'];
    imageTwo = json['image_two'];
  }

}
