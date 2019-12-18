import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resideo_eshopping/util/logger.dart' as logger;

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> signOut();

}

class Auth implements BaseAuth {
  static const String TAG ="Auth";
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    String userId;
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((result){
      if(result != null)
        userId=result.user.uid;
      else
        userId=null;
    }).catchError((error){
      print(error);
    });
    return userId;
  }

  Future<String> signUp(String email, String password) async {
    String userId;
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password).then((result){
          if(userId != null)
            userId=result.user.uid;
          else
            userId=null;
    }).catchError((error){
      print(error);
    });
    return userId;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user;
    await _firebaseAuth.currentUser().then((result){
      user=result;
    }).catchError((error){
      print(error);
    });
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

}
