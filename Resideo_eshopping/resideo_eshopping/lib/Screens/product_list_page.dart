import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/repository/products_repository.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
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
  ScrollController _scrollController = ScrollController();
  List<Product> _products = <Product>[];
  List<Product> currentList = <Product>[];
  AnimationController controller;
  Animation<double> animation;
  String _currentlySelected = "All";

  @override
  Widget build(BuildContext context) {
    filterProducts();
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
          title: Text(widget.title),
          bottom: _createProgressIndicator(),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 100,
              width: 100,
//            child: PopupMenuButton(
//                child:Icon(Icons.filter_list),
//                //onSelected: () => setState(),
//                itemBuilder: (context) => [
//                  PopupMenuItem(
//                    child: Text('Men'),
//                  ),
//                  PopupMenuItem(
//                    child: Text('Women'),
//                  ),
//                  PopupMenuItem(
//                    child: Text('Kids'),
//                  )
//                ]
//            ),
//          ),
//          //
              child: dropdownWidget(),
            )
          ]),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            ListView.builder(
              itemCount: currentList.length,
              controller: _scrollController,
              itemBuilder: (context, index) => ProductsTile(currentList[index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownWidget() {
    return DropdownButton(
      icon: Icon(Icons.filter_list),
      //hint: new Text("Filter"),
      items: [
        DropdownMenuItem<String>(child: new Text("All"), value: "All"),
        DropdownMenuItem<String>(child: new Text("Men"), value: "Men"),
        DropdownMenuItem<String>(child: new Text("Women"), value: "Women"),
        DropdownMenuItem<String>(child: new Text("Kid"), value: "Kid")
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
                  _products = productlist;
                });
              }
            }));
    return productlist;
  }

  @override
  void initState() {
    super.initState();
    getProductList();
    controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    animation = Tween(begin: 0.0, end: 20.0).animate(controller);
    controller.repeat();
    _scrollController.addListener(() {});
    filterProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  void listenForProducts() async {
    Stream<Product> stream = await getProducts();
    stream.listen((Product products) {
      setState(() => _products.add(products));
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

  PreferredSize _createProgressIndicator() => PreferredSize(
      preferredSize: Size(double.infinity, 4.0),
      child: SizedBox(
          height: 4.0,
          child: LinearProgressIndicator(
            value: animation.value,
          )));
}