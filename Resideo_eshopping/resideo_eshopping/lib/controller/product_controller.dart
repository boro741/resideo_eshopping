import 'package:flutter/cupertino.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
import 'package:resideo_eshopping/util/firebase_database_helper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resideo_eshopping/util/logger.dart' as logger;

class ProductController {
  static const String TAG ="ProductController";
  static List<Product> products = <Product>[];
  List<Product> currentList = List<Product>();
  Dbhelper helper = Dbhelper();
  FirebaseDatabaseUtil _firebaseDatabaseUtil = new FirebaseDatabaseUtil();


  /*Method to update the product model by getting data from local database or by calling updateProductModel method and
  calling filterProducts method by passing user choice and finally return the filter product list to product list screen
   */
  Future<List<Product>> getProductList(String value) async {
    if (products.length == 0) {
      List<Product> productlist = List<Product>();

      await helper.getProductListDb().then((result) async {
        int count = result.length;
        for (int i = 0; i < count; i++) {
          productlist.add(Product.fromJSON(result[i]));
        }
        if (productlist.length == 0)
          await updateProductModel();
        else {
          products = productlist;
        }
      }).catchError((error){
        logger.error(TAG, " Error in getProductList: "+ value +" " +error);
//        print(error);
      });
    }
    return filterProducts(value);
  }

  //Method to fetch products from API
  Future<List<Product>> fetchProducts(http.Client client) async {
    var response;
    try {
       response = await client.get(
          'https://fluttercheck-5afbb.firebaseio.com/Products.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1');
    }catch(error)
    {
//      print(error);
      logger.error(TAG, " Error in while fetching the Products: in method fetchProducts :" +error);
    }
    if(response.body == null)
//      print("Connection Issue with Api");
      logger.error(TAG, "Connection Issue with Api :" );

    return parseProducts(response.body);
  }

  //Method to decode the Products json and convert it into list of product object
  List<Product> parseProducts(String responseBody) {
    List<Product> _localProductList;
    try {
      final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
       if(parsed != null) {
         _localProductList =
             parsed.map<Product>((json) => Product.fromJSON(json)).toList();
         if(_localProductList == null)
           logger.error(TAG, "Conversion from jsom map to product object have Issue :" );
//           print("Conversion from jsom map to product object have Issue");
       }else
//         print("JasonDecode not working");
      logger.error(TAG, "JasonDecode not working:" );
    }catch(e)
    {
      logger.error(TAG, " " +e );
    }
    return _localProductList;
  }

  void init() {
    _firebaseDatabaseUtil.initState();
  }

  //Method to update the product model with list of products and add products in local database
  Future updateProductModel() async {
    await fetchProducts(http.Client()).then((result) {
      if(result != null) {
        products = result;
        helper.addAllProduct(products);
      }else
        {
          print("Product are not fetched from the API");
        }
    }).catchError((error){
      print(error);
    });
  }

  //Method to filter the product on product list screen based on user input
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

  //Method to return the update value of product quantity
  int _decreaseInventoryCount(Product product) {
    if (product.quantity > 0)
      return (product.quantity - 1);
    else
      return 0;
  }


  //Method to update the inventory count in product model,firebase and local database when customer purchase the product
  void updateInventory(Product product) {
    helper
        .updateInventoryById(product.id, _decreaseInventoryCount(product))
        .then((result) {
      if (result == 1) {
        product.quantity = product.quantity - 1;
        _firebaseDatabaseUtil.updateProduct(product);
      }else
        print("Updating in local database is failed");
    }).catchError((error){
      print(error);
    });
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
