import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/Screens/product_detail.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsTile extends StatelessWidget {
  Product _products;
  //Product pd;
  ProductsTile(this._products);
  Widget widget;

  @override 
  Widget build(BuildContext context) { 
  void navigateToProductdetail(Product pd) async{
  //Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(pd)));
  Navigator.push(context, ScaleRoute(page: ProductDetail(pd)));
  }
    return Column(
      children: <Widget>[
        Card(
          color: (_products.quantity != 0 ? Color.fromRGBO(255, 255, 255, 1.0) : Color.fromRGBO(255, 255, 255, 0.1)),
          child: ListTile(
            isThreeLine: true,
            title: PlatformText(_products.title),
            subtitle:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PlatformText(_products.sDesc),
                Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.rupeeSign, size: 10,),
                    PlatformText((_products.price).toString()),
                  ]   
                ),
              ],
            ),
            onTap: (){ navigateToProductdetail(_products);},
            
            leading: 
            Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(_products.thumbnail, height: 50.0, fit: BoxFit.fill,),
            ),
          ),
        ),
        //Divider()
      ],
    );
  }

/*  
  Widget showThumbnail(int quantity){
    if(quantity != 0){
      return Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(_products.thumbnail, height: 50.0, fit: BoxFit.fill,),
            ),
            Center(
              child: Text("OUT OF STOCK",
              style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 8.0,
              color: Colors.red)),
            )
          ],
        ),
      );
    }
    else{
      return Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(_products.thumbnail, height: 50.0, fit: BoxFit.fill,),
            );
    }
  }
  */
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