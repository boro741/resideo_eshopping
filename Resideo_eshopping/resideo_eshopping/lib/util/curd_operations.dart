import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:resideo_eshopping/model/product.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _productDBRef;

  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseError error;
  Product product;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _productDBRef = database.reference().child("Products");
    database.reference().child("Products").once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getProductDB() {
    return _productDBRef;
  }

  void deleteProduct(Product product) async {
    await _productDBRef.child(product.id.toString()).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  updateProduct(Product product) async {
    int x = product.id;
    await _productDBRef.child((x - 1).toString()).update({
      "Inventory": product.quantity,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}
