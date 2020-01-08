import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:resideo_eshopping/model/product.dart';

Future<String> loadProductsAsset() async {
  return await rootBundle.loadString('assets/products.json');
}

Future<List<Product>> loadProducts() async {
  List<Product> list = new List<Product>();
  String data = await loadProductsAsset();
  final jsonResponse = json.decode(data);
  var res = jsonResponse["Products"] as List;
  list = res.map<Product>((json) => Product.fromJSON(json)).toList();
  return list;
}