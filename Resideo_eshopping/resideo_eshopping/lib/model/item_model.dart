class ItemModel {
  String _category;
  String _image;
  int _inventory;
  String _longDescription;
  int _price;
  int _productId;
  String _productName;
  int _rating;
  String _review;
  String _shortDesciption;
  String _thumbnail;

  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    _category = parsedJson['Category'];
    _image = parsedJson['Image'];
    _inventory = parsedJson['Inventory'];
    _longDescription = parsedJson['LongDescription'];
    _price = parsedJson['Price'];
    _productId = parsedJson['ProductId'];
    _productName = parsedJson['ProductName'];
    _rating = parsedJson['Rating'];
    _review = parsedJson['Review'];
    _shortDesciption = parsedJson['ShortDescription'];
    _thumbnail = parsedJson['Thumbnail'];
  }

  String get Category => _category;
  String get Image => _image;
  int get Inventory => _inventory;
  String get LongDescription => _longDescription;
  int get Price => _price;
  int get ProductId => _productId;
  String get ProductName => _productName;
  int get rating => _rating;
  String get Review => _review;
  String get ShortDescription => _shortDesciption;
  String get Thumbnail => _thumbnail;
}
