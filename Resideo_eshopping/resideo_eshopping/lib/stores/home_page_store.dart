import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;


abstract class _HomePageStore with Store{

  @observable
  bool logInButtonPress = false;

  void onLoggedIn(){
    logInButtonPress=false;
  }

}