import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseDatabaseUtil {
  DatabaseReference _dbRef;
  FirebaseDatabase database;
  User user;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    database= new FirebaseDatabase();
    _dbRef = database.reference();
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  updateProduct(Product product) async {
    int x;
    if(product != null) {
      x = product.id;
      await _dbRef.child('Products').child((x - 1).toString()).update({
        "Inventory": product.quantity,
      }).then((_) {
        print('Transaction  committed.');
      }).catchError((error){
        print(error);
      });
    }  else
      print("Product argument passed in update product is bull");
  }

  Future<bool> deleteProfilePicture(FirebaseUser user) async {
    bool _isImageDeleted = false;
    if(user != null){
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child("profile pic" + user.uid.toString());
    await storageReference.delete().then((result) async {
      await updateData(user, null, null, true).then((result) {
        _isImageDeleted = true;
      });
    }).catchError((error) {
      print(error);
    });
    }else
      print("Firebase user passed in deleteProfilePicture is null");
    return _isImageDeleted;
  }

  Future sendData(
      FirebaseUser user, User userInfo, String _uploadFileUrl) async {
    if(user != null && userInfo != null) {
      await _dbRef.child('Users').child(user.uid.toString()).set({
        'name': userInfo.name,
        'phone': userInfo.phone,
        'address': userInfo.address,
        'zipcode': userInfo.zipcode,
        'imageUrl': _uploadFileUrl
      }).then((result) {
        print("profile created");
      }).catchError((onError) {
        print(onError);
      });
    }else
      print("passed argument in senddata method in firebase_database_helper file in null");
  }

  Future updateData(FirebaseUser user, User userInfo, String _uploadFileUrl,
      bool _deleteProfilePicture) async {
    if(user != null && userInfo != null) {
      if (_deleteProfilePicture) {
        await _dbRef
            .child('Users')
            .child(user.uid.toString())
            .update({'imageUrl': _uploadFileUrl}).then((result) {
          print("ImageUrl deleted");
        }).catchError((onError) {
          print(onError);
        });
      } else if (_uploadFileUrl != null) {
        await _dbRef.child('Users').child(user.uid.toString()).update({
          'name': userInfo.name,
          'phone': userInfo.phone,
          'address': userInfo.address,
          'zipcode': userInfo.zipcode,
          'imageUrl': _uploadFileUrl
        }).then((result) {
          print("profile updated with profile picture");
        }).catchError((onError) {
          print(onError);
        });
      } else {
        await _dbRef.child('Users').child(user.uid.toString()).update({
          'name': userInfo.name,
          'phone': userInfo.phone,
          'address': userInfo.address,
          'zipcode': userInfo.zipcode,
        }).then((result) {
          print("profile updated without profile picture");
        }).catchError((onError) {
          print(onError);
        });
      }
    }else
      print("passed argument in updatedata method in firebase_database_helper file in null");
  }

  Future<User> getUserData(FirebaseUser _user) async {
    try {
      if(_user != null) {
        await _dbRef
            .child('Users')
            .child(_user.uid.toString())
            .once()
            .then((DataSnapshot snapshot) {
          user = User.fromSnapshot(snapshot);
        }).catchError((error){
          print(error);
        });
      }else
        print("User passed in getUserData is null");
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<bool> updateUserProfile(
      FirebaseUser user, File image, User userInfo, bool isEdit) async {

    bool _isCreateUpdateSuccessfull = false;
    StorageReference storageReference;

    if (isEdit && image == null)
      await updateData(user, userInfo, null, false).then((result) {
        _isCreateUpdateSuccessfull = true;
      });
    else if (image == null)
      await sendData(user, userInfo, null).then((result) {
        _isCreateUpdateSuccessfull = true;
      });
    else {
      try {
        storageReference = FirebaseStorage.instance
            .ref()
            .child("profile pic" + user.uid.toString());
        StorageUploadTask uploadTask = storageReference.putFile(image);
        await uploadTask.onComplete;
        print('File Uploaded');
      }catch(error)
    {
      print(error);
    }
      await storageReference.getDownloadURL().then((fileURL) async {
        if (isEdit)
          await updateData(user, userInfo, fileURL, false).then((result) {
            _isCreateUpdateSuccessfull = true;
          });
        else
          await sendData(user, userInfo, fileURL).then((result) {
            _isCreateUpdateSuccessfull = true;
          });
      }).catchError((error){
        print(error);
      });
    }
    return _isCreateUpdateSuccessfull;
  }
}
