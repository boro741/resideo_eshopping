// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) {
  return Place(
      json['Name'] as String,
      json['Image'] as String,
      json['ShortDescription'] as String,
      json['Latitude'] as String,
      json['Longitude'] as String);
}

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'Name': instance.name,
      'Image': instance.imageUrl,
      'ShortDescription': instance.sdesc,
      'Latitude': instance.latitude,
      'Longitude': instance.longitude
    };
