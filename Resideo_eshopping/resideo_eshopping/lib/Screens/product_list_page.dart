import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/repository/products_repository.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
import 'package:resideo_eshopping/widgets/drawer.dart';
import 'package:resideo_eshopping/widgets/products_tile.dart';

class ProductsListPage extends StatefulWidget {
  ProductsListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage>
    with SingleTickerProviderStateMixin {
  Dbhelper helper = Dbhelper();
  List<Product> newList = List<Product>();
  String dropdownValue = 'Categories';
  List<Product> _products = <Product>[];
  List<Product> currentList = <Product>[];
  String _currentlySelected = "All";
  bool _isProgressBarShown = true;
  
  @override
  Widget build(BuildContext context) {
    filterProducts();
    var key = GlobalKey<ScaffoldState>();
    Widget widget;

  if(_isProgressBarShown){
    widget = Center(
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
    widget = ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),

      itemCount: currentList.length,
      itemBuilder: (context, index) => ProductsTile(currentList[index]),
    );
  }

    return Scaffold(
      key: key,
      drawer: AppDrawer(),
      appBar: AppBar(
          title: PlatformText("Resideo eShopping"),
          actions: <Widget> [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 100,
              width: 100,
              child: dropdownWidget(),
              
            )
          ]),
      body: widget,
    );
  }

  Widget dropdownWidget() {
    return DropdownButton(
      icon: Icon(Icons.filter_list),
      //hint: new Text("Filter"),
      items: [
        DropdownMenuItem<String>(child: PlatformText("All"), value: "All"),
        DropdownMenuItem<String>(child: PlatformText("Men"), value: "Men"),
        DropdownMenuItem<String>(child: PlatformText("Women"), value: "Women"),
        DropdownMenuItem<String>(child: PlatformText("Kid"), value: "Kid")
      ],
      onChanged: (String value) {
        _currentlySelected = value;
        setState(() {
          print("You Selected :$_currentlySelected");
        });
      },
      isExpanded: false,
    );
  }

  List<Product> getProductList() {
    List<Product> productlist = List<Product>();
    helper
        .initializedb()
        .then((result) => helper.getProductListDb().then((result) {
              int count = result.length;
              for (int i = 0; i < count; i++) {
                productlist.add(Product.fromObject(result[i]));
              }
              if (productlist.length == 0)
                listenForProducts();
              else {
                setState(() {
                  _isProgressBarShown = false;
                  _products = productlist;
                });
              }
            }));
    return productlist;
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

    getProductList();
    filterProducts();
  }

  void listenForProducts() async {
    //_isProgressBarShown = true;
    Stream<Product> stream = await getProducts();
    stream.listen((Product products) {
      setState(() {
        _isProgressBarShown = false;
        _products.add(products);
      } );
    }, onDone: () {
      helper.addAllProduct(_products);
    });
  }

  filterProducts() {
    currentList.clear();
    if (_currentlySelected == "All") {
      currentList.addAll(_products);
    } else {
      for (Product c in _products) {
        if (c.category == _currentlySelected) {
          currentList.add(c);
        }
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: PlatformText("Internet needed!"),
            content: PlatformText("You may want to exit the app here"),
            actions: <Widget>[
              FlatButton(child: PlatformText("Cancel"), onPressed: () => Navigator.of(context).pop(false)),
              FlatButton(child: PlatformText("Exit"), onPressed: () => Navigator.of(context).pop(true))],
          ),
    );
  }

}
