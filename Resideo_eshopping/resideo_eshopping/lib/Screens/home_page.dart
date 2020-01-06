import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:resideo_eshopping/Screens/product_list_page.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:resideo_eshopping/stores/home_page_store.dart';
import 'package:resideo_eshopping/widgets/progress_indicator.dart';

class HomePage extends StatelessWidget{

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

