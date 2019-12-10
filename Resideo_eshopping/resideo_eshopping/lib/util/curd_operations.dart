import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:resideo_eshopping/model/User.dart';

class FirebaseDatabaseUtil {
  DatabaseReference _productDBRef;
  DatabaseReference _userDBRef;

  FirebaseDatabase database = new FirebaseDatabase();
  DatabaseError error;
  Product product;
  User user;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _productDBRef = database.reference().child("Products");
    _userDBRef = database.reference().child("Users");
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

  Future sendData(FirebaseUser user,User userInfo,String _uploadFileUrl) async
  {
    await _userDBRef.child(user.uid.toString()).set({
      'name' : userInfo.name,
      'phone' : userInfo.phone,
      'address' : userInfo.address,
      'Zipcode' : userInfo.zipcode,
      'imageUrl' : _uploadFileUrl
    }).then((result){
      print("profile updated");
    }).catchError((onError){
      print(onError);
    });
  }

  Future<User> getUserData(FirebaseUser _user) async
  {
    await _userDBRef.child(_user.uid.toString()).once().then((DataSnapshot snapshot){
      user=User.fromSnapshot(snapshot);
    });
    return user;
  }
 
 Future updateUserProfile(FirebaseUser user,File image,User userInfo) async {    
   StorageReference storageReference = FirebaseStorage.instance.ref().child("profile pic"+user.uid.toString());
   StorageUploadTask uploadTask = storageReference.putFile(image);   
   await uploadTask.onComplete;  
   print('File Uploaded');    
   storageReference.getDownloadURL().then((fileURL) {    
    sendData(user, userInfo, fileURL);  
   });    
 } 

}

 
