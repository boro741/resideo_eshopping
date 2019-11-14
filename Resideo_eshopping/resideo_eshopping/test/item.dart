import 'dart:convert';

class Item {
  int id;
  String name;
  double price;
  int stock;
  bool active;

  Item({this.id, this.name, this.price, this.stock, this.active});
  factory Item.fromJson(Map<String, dynamic> json) => _itemFromJson(json);
}

Item _itemFromJson(Map<String, dynamic> json) {
  return Item(
    id: json['id'] as int,
    name: json['name'] as String,
    price: json['price'] as double,
    stock: json['stock'] as int,
    active: json['active'] as bool,
  );
}
