
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product{

  @JsonKey(name: 'ProductId')
  int id;
  @JsonKey(name: 'ProductName')
  String title;
  @JsonKey(name: 'ShortDescription')
  String sDesc;
  @JsonKey(name: 'Image')
  String imgUrl;
  @JsonKey(name: 'Price')
  int price;
  @JsonKey(name: 'Inventory')
  int quantity;
  @JsonKey(name: 'LongDescription')
  String lDesc;
  @JsonKey(name: 'Category')
  String category;
  @JsonKey(name: 'Rating')
  int rating;
  @JsonKey(name: 'Review')
  String review;
  @JsonKey(name: 'Thumbnail')
  String thumbnailUrl;
  @JsonKey(name: 'FAQ')
  String faqUrl;
  @JsonKey(name: 'ProductVideo')
  String pVideoUrl;
  @JsonKey(name: 'Latitude')
  String latitude;
  @JsonKey(name: 'Longitude')
  String longitude;
  
  Product(this.id,this.title,this.sDesc,this.imgUrl,this.price,this.quantity,this.lDesc,this.category,this.rating,this.review,this.thumbnailUrl,this.faqUrl,this.pVideoUrl,this.latitude,this.longitude);
  Product.withId(this.id,this.title,this.sDesc,this.imgUrl,this.price,this.quantity,this.lDesc,this.category,this.rating,this.review,this.thumbnailUrl,this.faqUrl,this.pVideoUrl,this.latitude,this.longitude);

   factory Product.fromJSON(Map<String,dynamic> jsonMap) => _$ProductFromJson(jsonMap);

   Map<String, dynamic> toJson() => _$ProductToJson(this);
}