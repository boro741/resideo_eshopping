
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;


abstract class _HomePageStore with ChangeNotifier, Store{

  static const String TAG ="HomePage";

  FirebaseAuth _auth = FirebaseAuth.instance;

  @observable
  Status status = Status.Unauthenticated;

  @observable
  String userId = "";

  @observable
  bool logInButtonPress = false;

  @action
  bool onlogInButtonPress(){
    return logInButtonPress=true;
  }

  void onLoggedIn(){
    logInButtonPress=false;
  }

  @action
  Future onSignedOut() async{
    logInButtonPress = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    userId = "";
  }

//  Future<FirebaseUser> getCurrentUser() async {
//    FirebaseUser user;
//    await _auth.currentUser().then((result){
//      user=result;
//    }).catchError((error){
//      print(error);
//    });
//    return user;
//  }


}