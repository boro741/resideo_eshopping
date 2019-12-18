import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:resideo_eshopping/util/firebase_database_helper.dart';

part 'product_controller.g.dart';

class ProductController = ProductControllerBase with _$ProductController;
abstract class ProductControllerBase with Store {

  @observable
  List<Product> products = <Product>[];

  @observable
  List<Product> currentList = List<Product>();

  Dbhelper helper = Dbhelper();
  FirebaseDatabaseUtil help = new FirebaseDatabaseUtil();

  @action
  Future<List<Product>> getProductList(String value) async {
    if (products.length == 0) {
      List<Product> productlist = List<Product>();

      await helper.getProductListDb().then((result) async{
        int count = result.length;
        for (int i = 0; i < count; i++) {
          productlist.add(Product.fromJSON(result[i]));
        }
        if (productlist.length == 0)
          await updateProductModel();
        else {
          products = productlist;
        }
      });
    }
    return filterProducts(value);
  }

  //Method to fetch products from API
  Future<List<Product>> fetchProducts(http.Client client) async{
    final response = await client.get('https://fluttercheck-5afbb.firebaseio.com/Products.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1');

    return parseProducts(response.body);
  }


  //Method to decode the Products json and convert it into list of product object
  List<Product> parseProducts(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Product>((json) => Product.fromJSON(json)).toList();
  }

  void init() {
    help.initState();
  }


  @action
  //Method to update the product model with list of products
  Future updateProductModel() async {
    await fetchProducts(http.Client()).then((result){
      products=result;
      helper.addAllProduct(products);
    });
    //notifyListeners();
  }

  @action
  filterProducts(String value) {
    currentList.clear();
    if (value == "All") {
      currentList.addAll(products);
    } else {
      for (Product c in products) {
        if (c.category == value) {
          currentList.add(c);
        }
      }
    }
    return currentList;
  }

  @action
  int _decreaseInventoryCount(Product product) {
    if (product.quantity > 0)
      return (product.quantity - 1);
    else
      return 0;
  }

  @action
  void updateInventory(Product product) {
    helper
        .updateInventoryById(product.id, _decreaseInventoryCount(product))
        .then((result) {
      if (result != null) {
        product.quantity = product.quantity - 1;
        help.updateProduct(product);
      }
    });
    //notifyListeners();
  }

  //Method to enable or disable the order now button in product detail screen based on quantity of product
  bool enableDisableOrderNowButton(int quantity) {
    if (quantity <= 0)
      return true;
    else
      return false;
  }

  //Method to display the stock detail based on quantity of product on product detail page
  String inventoryDetail(int quantity) {
    String inventoryDetailMsg;

    if (quantity <= 0) {
      inventoryDetailMsg = "Out of Stock";
      return inventoryDetailMsg;
    } else if (quantity < 5) {
      inventoryDetailMsg = "Only $quantity left";
      return inventoryDetailMsg;
    } else {
      inventoryDetailMsg = "In Stock";
      return inventoryDetailMsg;
    }
  }
 //Method to set the color of inventory detail message on product detail screen
  dynamic inventoryDetailColor(int quantity){

    if(quantity < 5)
      return Color(0xFFF44336);
    else
      return Color(0xFF00C853);
  }

}
