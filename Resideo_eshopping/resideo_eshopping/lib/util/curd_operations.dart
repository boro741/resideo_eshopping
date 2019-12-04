import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:resideo_eshopping/model/product.dart';

class FirebaseDatabaseUtil {

  DatabaseReference _userRef;
  StreamSubscription<Event> _counterSubscription;
  StreamSubscription<Event> _messagesSubscription;
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
    // Demonstrates configuring to the database using a file

    // Demonstrates configuring the database directly

    _userRef = database.reference().child("Products");
    database.reference().child("Products").once().then((DataSnapshot snapshot) {
      print('Connected to second database and read ${snapshot.value}');
    });
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);


  }

  DatabaseError getError() {
    return error;
  }


  DatabaseReference getUser() {
    return _userRef;
  }

  void deleteUser(Product product) async {
    await _userRef.child(product.id.toString()).remove().then((_) {
      print('Transaction  committed.');
    });
  }

   updateUser(Product product,int newInventoryValue) async {
    int x = product.id;
       await _userRef.child((x -1).toString()).update({
      "Inventory": product.quantity,

    }).then((_) {
      print('Transaction  committed.');
    });
  }
    updateUser1(String id,int newInventoryValue) async {
      Product product;

    return(await _userRef.child(product.id.toString()).update({
      "Inventory": 10
    }).then((_) {
      print('Transaction  committed.');
    }));
  }

  void dispose() {
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }
}
