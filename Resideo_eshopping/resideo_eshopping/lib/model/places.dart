
import 'package:json_annotation/json_annotation.dart';

part 'places.g.dart';

@JsonSerializable()
class Place{

  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Image')
  String imageUrl;
  @JsonKey(name: 'ShortDescription')
  String sdesc;
  @JsonKey(name: 'Latitude')
  String latitude;
  @JsonKey(name: 'Longitude')
  String longitude;



  Place(this.name,this.imageUrl,this.sdesc,this.latitude,this.longitude);
  Place.withId(this.name,this.imageUrl,this.sdesc,this.latitude,this.longitude);

  factory Place.fromJSON(Map<String,dynamic> jsonMap) => _$PlaceFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}