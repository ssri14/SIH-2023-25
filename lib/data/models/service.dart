import 'package:json_annotation/json_annotation.dart';

part 'service.g.dart';

@JsonSerializable()
class RescueService {
  final String name;
  final String id;
  final String type;
  final String phoneNo;
  final double lat;
  final double lng;

  RescueService(
      {required this.name,
      required this.type,
      required this.id,
      required this.phoneNo,
      required this.lat,
      required this.lng});

  Map<String, dynamic> toJson() => _$RescueServiceToJson(this);

  factory RescueService.fromJson(json) => _$RescueServiceFromJson(json);


}
