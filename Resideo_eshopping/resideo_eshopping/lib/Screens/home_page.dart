import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:resideo_eshopping/Screens/login_page.dart';
import 'package:resideo_eshopping/Screens/product_list_page.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:resideo_eshopping/services/authentication.dart';
import 'package:resideo_eshopping/stores/home_page_store.dart';
import 'package:resideo_eshopping/widgets/progress_indicator.dart';

class HomePage extends StatelessWidget{
  HomePage({this.auth});
  final BaseAuth auth;

  final _homeStore = HomePageStore();

  @override
  Widget build(BuildContext context){
            final user = Provider.of<UserRepository>(context);
            switch(user.status){
              case Status.Uninitialized:
                return ProgressIndicatorWidget();
                break;

              case Status.Unauthenticated:
              case Status.Authenticating:
                return Observer(
                  builder: (context){
                    if(_homeStore.logInButtonPress){
                      return LoginPage( onSignedIn: _homeStore.onLoggedIn);
                    }
                    else{
                      return ProductsListPage(user: user.user, online: _homeStore.onlogInButtonPress, offline: _homeStore.onSignedOut);
                    }

                  },
                );
                break;

              case Status.Authenticated:
                  return Observer(
                    builder: (context) {
                      return ProductsListPage(
                          user: user.user,
                          online: _homeStore.onlogInButtonPress,
                          offline: _homeStore.onSignedOut);
                    }
                  );
                break;

              default: return ProgressIndicatorWidget();

            }

          }
}

