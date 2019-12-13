
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
  String faq;
  @JsonKey(name: 'ProductVideo')
  String pVideo;
  
  Product(this.title,this.sDesc,this.imgUrl,this.price,this.quantity,this.lDesc,this.category,this.rating,this.review,this.thumbnailUrl,this.faq,this.pVideo);
  Product.withId(this.id,this.title,this.sDesc,this.imgUrl,this.price,this.quantity,this.lDesc,this.category,this.rating,this.review,this.thumbnailUrl,this.faq,this.pVideo);





  Map<String,dynamic> tomap()
  {
    Map<String,dynamic> productList=Map<String,dynamic>();
    productList['id']=id;
    productList['title']=title;
    productList['s_desc']=sDesc;
    productList['img']=imgUrl;
    productList['price']=price;
    productList['quantity']=quantity;
    productList['l_desc']=lDesc;
    productList['category']=category;
    productList['rating']=rating;
    productList['review']=review;
    productList['thumbnail']=thumbnailUrl;
    productList['faq']=faq;
    productList['pVideo']=pVideo;
    return productList;
  }

  Product.fromObject(dynamic o)
  {
    this.id=o['id'];
    this.title=o['title'];
    this.sDesc=o['s_desc'];
    this.imgUrl=o['img'];
    this.price=o['price'];
    this.quantity=o['quantity'];
    this.lDesc=o['l_desc'];
    this.category=o['category'];
    this.rating=o['rating'];
    this.review=o['review'];
    this.thumbnailUrl=o['thumbnail'];
    this.faq=o['faq'];
    this.pVideo=o['pVideo'];
  }

   factory Product.fromJSON(Map<String,dynamic> jsonMap) => _$ProductFromJson(jsonMap);
}