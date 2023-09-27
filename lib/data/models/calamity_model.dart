class Calamity {
  String? sId;
  String? news;
  String? type;
  String? location;
  String? time;

  Calamity({this.sId, this.news, this.type, this.location, this.time});

  Calamity.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    news = json['news'];
    type = json['type'];
    location = json['location'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['news'] = news;
    data['type'] = type;
    data['location'] = location;
    data['time'] = time;
    return data;
  }
}
