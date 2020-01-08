import 'package:flutter_test/flutter_test.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

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


void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();
  List<Product> products = await loadProducts();
  ProductController productController = ProductController();
  productController.products = products;

  test("filter for all", () {
    expect(25, productController.filterProducts('All').length);
  });

  test("filter for men", () {
    expect(9, productController.filterProducts('Men').length);
  });

  test("filter for women", () {
    expect(8, productController.filterProducts('Women').length);
  });

  test("filter for kid", () {
    expect(8, productController.filterProducts('Kid').length);
  });

}
