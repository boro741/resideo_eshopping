import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';
import 'package:resideo_eshopping/widgets/products_tile.dart';
import 'package:resideo_eshopping/services/authentication.dart';
import 'package:resideo_eshopping/controller/root_page.dart';

class ProductsListPage extends StatefulWidget {
 // ProductsListPage({Key key,this.userLogin}) : super(key: key);
 // final UserLogin userLogin;
 ProductsListPage(this.user,this.online,this.offline,this.auth);
 final FirebaseUser user;
 final VoidCallback online;
 final VoidCallback offline;
 final BaseAuth auth;
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> 
    with SingleTickerProviderStateMixin {
  ProductController productController=ProductController();
  String dropdownValue = 'Categories';
  List<Product> currentList = <Product>[];
  bool _isProgressBarShown = true;
  AnimationController controller;
  Animation<double> animation;
  String _name;
  String _email;
  String _imageUrl;
  

  getProduct(String value){
  productController.getProductList(value).then((result){setState((){currentList=result;
  _isProgressBarShown = false;
  });});
  }
  
  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    Widget widget1;

  if(_isProgressBarShown){
    widget1 = Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: PlatformCircularProgressIndicator(
          android: (_) => MaterialProgressIndicatorData(),
          ios: (_) => CupertinoProgressIndicatorData(),
        ),
      )
    );
  }
  else{
    widget1 = ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),

      itemCount: currentList.length,
      itemBuilder: (context, index) => ProductsTile(currentList[index]),
    );
  }

    return Scaffold(
      key: key,
      drawer: Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
                child: UserAccountsDrawerHeader(
                  accountName: Text("Name"),
                  accountEmail: Text("widget.user.email.toString()"),
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
              
          ExpansionTile(
            title: Text("Filter"),
            children: <Widget>[
              _createDrawerItem(icon: FontAwesomeIcons.male, text: 'All',onTap: () => getProduct('All')),
              _createDrawerItem(icon: FontAwesomeIcons.male, text: 'Men',onTap: () => getProduct('Men')),
              _createDrawerItem(icon: FontAwesomeIcons.female, text: 'Women', onTap: () => getProduct('Women')),
              _createDrawerItem(icon: FontAwesomeIcons.child, text: 'Kids', onTap: () => getProduct('Kid')),
            ],
          ),
          Divider(),
          _createDrawerItem(icon: FontAwesomeIcons.user, text: 'My Account'),
          _loginSignupButton(),
        ],
      ),
    ),
      appBar: AppBar(
          title: PlatformText("Resideo eShopping"),
          ),
      body: widget1,
    );
  }

/*
  Widget dropdownWidget() {
    return DropdownButton(
      icon: Icon(Icons.filter_list),
      //hint: new Text("Filter"),
      items: [
        DropdownMenuItem<String>(child: PlatformText("All"), value: "All",),
        DropdownMenuItem<String>(child: PlatformText("Men"), value: "Men"),
        DropdownMenuItem<String>(child: PlatformText("Women"), value: "Women"),
        DropdownMenuItem<String>(child: PlatformText("Kid"), value: "Kid")
      ],
      onChanged: (String value) {
        getProduct(value);
      },
      isExpanded: false,
    );
  }
*/
  Widget _loginSignupButton(){
       if(widget.user != null)
          {
            return PlatformButton(
            onPressed: () async{
             try {
                   await widget.auth.signOut();
                  widget.offline();
                  } catch (e) {
                   print(e);
                  }
            },
            child: PlatformText('LOG OUT'),
            color: Color.fromRGBO(255, 0, 0, 1.0),
            android: (_) => MaterialRaisedButtonData(),
            ios: (_) => CupertinoButtonData()
          );
          }
          else
          {
          return PlatformButton(
            onPressed: (){
            widget.online();
            },
            child: PlatformText('LOG In'),
            color: Color.fromRGBO(255, 0, 0, 1.0),
            android: (_) => MaterialRaisedButtonData(),
            ios: (_) => CupertinoButtonData()
          );
          }
  }

  Widget _createDrawerItem(
      {IconData icon, String text, String value, GestureTapCallback onTap}) {
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
      onTap: onTap,
    );
  }

  @override
  void initState() {
    super.initState();

    Timer.run(() {
      try {
        InternetAddress.lookup('google.com').then((result) {
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            print('connected');
          } else {
            _showDialog(); // show dialog
          }
        }).catchError((error) {
          _showDialog(); // show dialog
        });
      } on SocketException catch (_) {
        _showDialog();
        print('not connected'); // show dialog
      }
    });
   // RootPage(auth: Auth(),checkIn: this,);

    getProduct("All");
  }

  // @override
  //  void userCheckIn(FirebaseUser user)
  //  {
  //     setState(() {
  //     _email=user.email.toString();
  //   });
  //  }
  
 
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Internet connection is required!"),
          ),
    );
  }

}

// abstract class UserLogin{
//   void login();
// }
