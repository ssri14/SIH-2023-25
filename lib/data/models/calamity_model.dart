import 'package:get/get.dart';

class Calamity {
  String? news;
  String? type;

  Calamity({this.news, this.type});

  Calamity.fromJson(Map<String, dynamic> json) {
    news = json['news'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['news'] = news;
    data['type'] = type;
    return data;
  }
}