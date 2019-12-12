import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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

  Future<bool> deleteProfilePicture(FirebaseUser user) async{
    bool _isImageDeleted=false;
    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        "profile pic" + user.uid.toString());
    await storageReference.delete().then((result) async{
      await updateData(user, null, null, true).then((result){
        _isImageDeleted=true;
      });
    }).catchError((error){
      print(error);
    });
    return _isImageDeleted;
  }

  Future sendData(FirebaseUser user,User userInfo,String _uploadFileUrl) async
  {
    await _userDBRef.child(user.uid.toString()).set({
      'name' : userInfo.name,
      'phone' : userInfo.phone,
      'address' : userInfo.address,
      'zipcode' : userInfo.zipcode,
      'imageUrl' : _uploadFileUrl
    }).then((result){
      print("profile updated");
    }).catchError((onError){
      print(onError);
    });
  }

  Future updateData(FirebaseUser user,User userInfo,String _uploadFileUrl,bool _deleteProfilePicture) async
  {
    if(_deleteProfilePicture)
      {
        await _userDBRef.child(user.uid.toString()).update({
          'imageUrl': _uploadFileUrl
        }).then((result) {
          print("ImageUrl deleted");
        }).catchError((onError) {
          print(onError);
        });
      }
    else
    if(_uploadFileUrl != null) {
      await _userDBRef.child(user.uid.toString()).update({
        'name': userInfo.name,
        'phone': userInfo.phone,
        'address': userInfo.address,
        'zipcode': userInfo.zipcode,
        'imageUrl': _uploadFileUrl
      }).then((result) {
        print("profile updated");
      }).catchError((onError) {
        print(onError);
      });
    }else
      {
        await _userDBRef.child(user.uid.toString()).update({
          'name': userInfo.name,
          'phone': userInfo.phone,
          'address': userInfo.address,
          'zipcode': userInfo.zipcode,
        }).then((result) {
          print("profile updated");
        }).catchError((onError) {
          print(onError);
        });
      }
  }

  Future<User> getUserData(FirebaseUser _user) async
  {
    try{
    await _userDBRef.child(_user.uid.toString()).once().then((DataSnapshot snapshot){
      user=User.fromSnapshot(snapshot);
    });
    }catch(e){
     print(e);
    }
    return user;
  }
 
 Future<bool> updateUserProfile(FirebaseUser user,File image,User userInfo,bool isEdit) async {
    bool _isCreateUpdateSuccessfull=false;
   if (isEdit && image == null)
     await updateData(user, userInfo, null).then((result) {
       _isCreateUpdateSuccessfull=true;
     });
   else if (image == null)
     await sendData(user, userInfo, null).then((result) {
       _isCreateUpdateSuccessfull=true;
     });
   else {
     StorageReference storageReference = FirebaseStorage.instance.ref().child(
         "profile pic" + user.uid.toString());
     StorageUploadTask uploadTask = storageReference.putFile(image);
     await uploadTask.onComplete;
     print('File Uploaded');
     await storageReference.getDownloadURL().then((fileURL) {
       if (isEdit)
         updateData(user, userInfo, fileURL).then((result){_isCreateUpdateSuccessfull=true;});
       else
         sendData(user, userInfo, fileURL).then((result){_isCreateUpdateSuccessfull=true;});
     });
   }
   return _isCreateUpdateSuccessfull;
 }
}

 
