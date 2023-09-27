import 'dart:ffi';

class RescueService {
  final String name;
  final String id;
  final String phoneNo;
  final double lat;
  final double lng;

  RescueService(
      {required this.name,
      required this.id,
      required this.phoneNo,
      required this.lat,
      required this.lng});

  factory RescueService.create(String name, String lat, String lng) =>
      RescueService(name: name, id: "123", phoneNo: '1234', lat: double.parse(lat) , lng: double.parse(lng));
}
