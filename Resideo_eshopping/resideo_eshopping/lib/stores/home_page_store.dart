import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

class HomePageStore = _HomePageStore with _$HomePageStore;


abstract class _HomePageStore with Store{

  @observable
  bool logInButtonPress = false;

  void onLoggedIn(){
    logInButtonPress=false;
  }

}