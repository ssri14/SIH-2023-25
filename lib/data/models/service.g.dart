// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RescueService _$RescueServiceFromJson(Map<String, dynamic> json) =>
    RescueService(
      name: json['name'] as String,
      type: json['type'] as String,
      id: json['id'] as String,
      phoneNo: json['phoneNo'] as String,
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$RescueServiceToJson(RescueService instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'type': instance.type,
      'phoneNo': instance.phoneNo,
      'lat': instance.lat,
      'lng': instance.lng,
    };
