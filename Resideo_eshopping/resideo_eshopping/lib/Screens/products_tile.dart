import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resideo_eshopping/Screens/product_detail.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resideo_eshopping/model/User.dart';
import 'package:resideo_eshopping/util/logger.dart' as logger;

class ProductsTile extends StatelessWidget {
  Product _products;
  FirebaseUser user;
  VoidCallback online;
  VoidCallback offline;
  User userInfo;
  ProductsTile(this._products,this.user,this.online,this.offline,this.userInfo);
  Widget widget;

  @override 
  Widget build(BuildContext context) {
    void navigateToProductdetail(Product pd, FirebaseUser user,
        VoidCallback online, VoidCallback offline,
        User userInfo) async {
          print(user);
      Navigator.push(context, ScaleRoute(
          page: ProductDetail(pd, user, online, offline, userInfo)));
    }
    if (_products == null)
      logger.info("ProductsTile", "Product object passed in product tile is null");
    else {
      return Column(
        children: <Widget>[
          Card(
            color: (_products.quantity != 0
                ? Color.fromRGBO(255, 255, 255, 1.0)
                : Color.fromRGBO(255, 255, 255, 0.5)),
            child: ListTile(
                isThreeLine: true,
                title: Text(_products.title),
                subtitle:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_products.sDesc),
                    Row(
                        children: <Widget>[
                          Icon(FontAwesomeIcons.rupeeSign, size: 10,),
                          Text((_products.price).toString()),
                        ]
                    ),

                  ],
                ),
                onTap: () {
                  navigateToProductdetail(
                      _products, user, online, offline, userInfo);
                },

                leading:
                Container(
                    margin: EdgeInsets.only(left: 6.0),
                    child: Stack(
                        children: <Widget>[
                          Image.network(_products.thumbnailUrl, height: 50.0,
                            fit: BoxFit.fill,),
                          (_products.quantity != 0) ? Text('') : Text(
                            'OUT OF STOCK!',
                            style: TextStyle(color: Colors.red, fontSize: 11.0),
                            textAlign: TextAlign.center,),
                        ]
                    )
                )
            ),
          ),
          //Divider()
        ],
      );
    }
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('userInfo', userInfo));
  }
}

class ScaleRoute extends PageRouteBuilder {
  final Widget page;
  ScaleRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
                scale: Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.fastOutSlowIn,
                  ),
                ),
                child: child,
              ),
        );
}