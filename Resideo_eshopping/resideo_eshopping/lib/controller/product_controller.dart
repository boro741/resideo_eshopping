
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
import 'package:resideo_eshopping/util/crud_operations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductController {
  static List<Product> products = <Product>[];
  List<Product> currentList = List<Product>();
  Dbhelper helper = Dbhelper();
  FirebaseDatabaseUtil help = new FirebaseDatabaseUtil();

  Future<List<Product>> getProductList(String value) async {
    if (products.length == 0) {
      List<Product> productlist = List<Product>();

      await helper.getProductListDb().then((result) async{
        int count = result.length;
        for (int i = 0; i < count; i++) {
          productlist.add(Product.fromObject(result[i]));
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


  //Method to update the product model with list of products
  Future updateProductModel() async {
  await fetchProducts(http.Client()).then((result){
    products=result;
    helper.addAllProduct(products);
  });
  }

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

  int _decreaseInventoryCount(Product product) {
    if (product.quantity > 0)
      return (product.quantity - 1);
    else
      return 0;
  }

  void updateInventory(Product product) {
    helper
        .updateInventoryById(product.id, _decreaseInventoryCount(product))
        .then((result) {
      if (result != null) {
        product.quantity = product.quantity - 1;
        help.updateProduct(product);
      }
    });
  }
}
