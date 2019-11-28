import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/model/product.dart';

class AppDrawer extends StatelessWidget {

  List<Product> currentList = <Product>[];
  List<Product> _products = <Product>[];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
                child: UserAccountsDrawerHeader(
                  accountName: Text("Ashish Rawat"),
                  accountEmail: Text("ashishrawat2911@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              ),
          //_createHeader(),
          //Divider(),
          ExpansionTile(
            title: Text("Filter"),
            children: <Widget>[
              _createDrawerItem(icon: Icons.collections_bookmark, text: 'Men', onTap: filterProducts()),
              _createDrawerItem(icon: Icons.collections_bookmark, text: 'Women', onTap: filterProducts()),
              _createDrawerItem(icon: Icons.collections_bookmark, text: 'Kids', onTap: filterProducts()),
            ],
          ),

          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'My Account'),
          PlatformButton(
            onPressed: (){},
            child: PlatformText('LOG OUT'),
            color: Color.fromRGBO(255, 0, 0, 1.0),
            android: (_) => MaterialRaisedButtonData(),
            ios: (_) => CupertinoButtonData()
          )
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData icon, String text, Key value, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: (){},
    );
  }

  filterProducts(){
    for (Product c in _products) {
        if (c.category == 'Men') {
          currentList.add(c);
        }
      }
  }  
}