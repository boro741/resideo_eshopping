// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['ProductName'] as String,
      json['ShortDescription'] as String,
      json['Image'] as String,
      json['Price'] as int,
      json['Inventory'] as int,
      json['LongDescription'] as String,
      json['Category'] as String,
      json['Rating'] as int,
      json['Review'] as String,
      json['Thumbnail'] as String,
      json['FAQ'] as String,
      json['ProductVideo'] as String)
    ..id = json['ProductId'] as int;
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'ProductId': instance.id,
      'ProductName': instance.title,
      'ShortDescription': instance.sDesc,
      'Image': instance.imgUrl,
      'Price': instance.price,
      'Inventory': instance.quantity,
      'LongDescription': instance.lDesc,
      'Category': instance.category,
      'Rating': instance.rating,
      'Review': instance.review,
      'Thumbnail': instance.thumbnailUrl,
      'FAQ': instance.faqUrl,
      'ProductVideo': instance.pVideoUrl
    };
