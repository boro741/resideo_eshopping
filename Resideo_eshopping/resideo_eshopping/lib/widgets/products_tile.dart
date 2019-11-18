import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resideo_eshopping/Screens/product_detail.dart';
import 'package:resideo_eshopping/model/product.dart';

class ProductsTile extends StatelessWidget {
  Product _products;
  ProductsTile(this._products);

  @override 
  Widget build(BuildContext context) { 
  void navigateToProductdetail(Product pd) async{
  Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetail(pd)));
  }
    return Column(
      children: <Widget>[
        Card(
          //color: Color.fromRGBO(255, 255, 255, 0.1),
          child: ListTile(
            isThreeLine: true,
            title: Text(_products.title),
            subtitle: //Text(_products.shortDescription),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_products.sDesc),
                Text((_products.price).toString()),
              ],
            ),
            onTap: (){ navigateToProductdetail(_products);},
            leading: Container(
              margin: EdgeInsets.only(left: 6.0),
              child: Image.network(_products.thumbnail, height: 50.0, fit: BoxFit.fill,),
            ),
          ),
        ),
        //Divider()
      ],
  );
  }
 

}