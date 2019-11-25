import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';
import 'package:resideo_eshopping/widgets/products_tile.dart';

class ProductsListPage extends StatefulWidget {
  ProductsListPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage>
    with SingleTickerProviderStateMixin {
  ProductController productController=ProductController();
  String dropdownValue = 'Categories';
  ScrollController _scrollController = ScrollController();
  List<Product> currentList = <Product>[];
  AnimationController controller;
  Animation<double> animation;


  void getProducts(String value){
  productController.getProductList(value).then((result){setState((){currentList=result;});});
  }
  
  @override
  Widget build(BuildContext context) {
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
        getProducts(value);
      },
      isExpanded: false,
    );
  }

  @override
  void initState() {
    super.initState();
    getProducts("All");
    controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    animation = Tween(begin: 0.0, end: 20.0).animate(controller);
    controller.repeat();
    _scrollController.addListener(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  PreferredSize _createProgressIndicator() => PreferredSize(
      preferredSize: Size(double.infinity, 4.0),
      child: SizedBox(
          height: 4.0,
          child: LinearProgressIndicator(
            value: animation.value,
          )));
}