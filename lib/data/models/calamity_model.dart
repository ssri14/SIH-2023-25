class Calamity {
  String? isApproved = "false";
  String? sId;
  String? news;
  String? type;
  num? lat;
  num? lng;
  String? location;
  String? time;

  Calamity(
      {this.isApproved,
      this.sId,
      this.news,
      this.type,
      this.lat,
      this.lng,
      this.location,
      this.time});

  Calamity.fromJson(Map<String, dynamic> json) {
    isApproved = json['isApproved'];
    sId = json['_id'];
    news = json['news'];
    type = json['type'];
    location = json['location'];
    time = json['time'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isApproved'] = isApproved;
    data['_id'] = sId;
    data['news'] = news;
    data['type'] = type;
    data['location'] = location;
    data['time'] = time;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
