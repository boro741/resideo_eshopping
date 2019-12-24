import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resideo_eshopping/Screens/login_page.dart';
import 'package:resideo_eshopping/controller/root_page.dart';
import 'package:resideo_eshopping/model/user_repository.dart';
import 'package:resideo_eshopping/services/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return RootPage(auth: Auth());
            case Status.Unauthenticated:
            case Status.Authenticating:
              return LoginPage();
            case Status.Authenticated:
              return RootPage(auth: Auth());
          }
        },
      ),
    );
  }
}