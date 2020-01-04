import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  UserRepository(this._auth);

  //final BaseAuth auth;
  FirebaseAuth _auth;
  FirebaseUser _user;
  String _userId;
  Status _status = Status.Uninitialized;

  bool logInButtonPress = false;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;
  FirebaseAuth get auth => _auth;
  String get userId => _userId;

  Future<String> signIn(String email, String password) async {

    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((result){
        if(result != null) {
          _userId = result.user.uid;
          print('$userId');
        }
        else
          _userId=null;
      });

      //return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      //return false;
    }
    return _userId;
  }

  Future<String> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
        email: email, password: password).then((result){
      if(_userId != null)
        _userId=result.user.uid;
      else
        _userId=null;
    }).catchError((error){
      print(error);
    });
    return _userId;
  }



  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _user = null;
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

}