class Product{

  int _id;
  String _title;
  String _sDesc;
  String _imgUrl;
  int _price;
  int _quantity;
  String _lDesc;
  String _category;
  int _rating;
  String _review;
  String _thumbnailUrl;
  
  Product(this._title,this._sDesc,this._imgUrl,this._price,this._quantity,this._lDesc,this._category,this._rating,this._review,this._thumbnailUrl);
  Product.withId(this._id,this._title,this._sDesc,this._imgUrl,this._price,this._quantity,this._lDesc,this._category,this._rating,this._review,this._thumbnailUrl);

  int get id => _id;
  String get title => _title;
  String get sDesc => _sDesc;
  String get img => _imgUrl;
  int get price => _price;
  int get quantity => _quantity;
  String get lDesc => _lDesc;
  String get category => _category;
  int get rating => _rating;
  String get review => _review;
  String get thumbnail => _thumbnailUrl;

  set title(String newtitle)
  {
    _title=newtitle;
  }

  set sDesc(String newSDesc){
     _sDesc=newSDesc;
  }

  set img(String newimg){
    _imgUrl=newimg;
  }

  set price(int newprice){
    _price=newprice;
  }

  set quantity(int newquantity){
    _quantity=newquantity;
  }

  set lesc(String newLDesc){
    _lDesc=newLDesc;
  }

  set category(String newcategory){
    _category=newcategory;
  }

  set rating(int newrating){
    _rating=newrating;
  }

  set review(String newreview){
    _review=newreview;
  }
  
  set thumbnail(String newthumbnail){
    _thumbnailUrl=newthumbnail;
  }

  Map<String,dynamic> tomap()
  {
    Map<String,dynamic> productList=Map<String,dynamic>();
    productList['id']=_id;
    productList['title']=_title;
    productList['s_desc']=_sDesc;
    productList['img']=_imgUrl;
    productList['price']=_price;
    productList['quantity']=_quantity;
    productList['l_desc']=_lDesc;
    productList['category']=_category;
    productList['rating']=_rating;
    productList['review']=_review;
    productList['thumbnail']=_thumbnailUrl;
    return productList;
  }

  Product.fromObject(dynamic o)
  {
    this._id=o['id'];
    this._title=o['title'];
    this._sDesc=o['s_desc'];
    this._imgUrl=o['img'];
    this._price=o['price'];
    this._quantity=o['quantity'];
    this._lDesc=o['l_desc'];
    this._category=o['category'];
    this._rating=o['rating'];
    this._review=o['review'];
    this._thumbnailUrl=o['thumbnail'];
  }

  Product.fromJSON(Map<String, dynamic> jsonMap) :
  _category = jsonMap['Category'],
  _imgUrl = jsonMap['Image'],
  _quantity = jsonMap['Inventory'],
  _lDesc = jsonMap['LongDescription'],
  _price = jsonMap['Price'],
  _id = jsonMap['ProductId'],
  _title = jsonMap['ProductName'],
  _rating = jsonMap['Rating'],
  _review = jsonMap['Review'],
  _sDesc = jsonMap['ShortDescription'],
  _thumbnailUrl = jsonMap['Thumbnail'];

}