import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:resideo_eshopping/model/eshopping_model.dart';
import 'package:resideo_eshopping/repository/products_repository.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';
import 'package:resideo_eshopping/widgets/products_tile.dart';

class ProductsListPage extends StatefulWidget {
  ProductsListPage({Key key, this.title}) : super(key: key);

  final  String title;

  @override 
  _ProductsListPageState createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage>{

  Dbhelper helper=Dbhelper();
  List<Product> newList=List<Product>();
  String dropdownValue = 'Categories';
  ScrollController _scrollController = ScrollController();
  Product mobile=Product('OnePlus','','',40000,5,'','',4,'','');
  Product car=Product('Audi','','',400000,5,'','',4,'','');
  List<Product> _products = <Product>[];
  // int count;

  final List<String> _dropdownValues = [
    "Filter",
    "Male",
    "Female",
    "Kids"
  ];
  String _currentlySelected = " "; 

  @override 
  Widget build(BuildContext context){
    var key = GlobalKey<ScaffoldState>();
    // setState(() {
    //   _products=getProductsList();
    //   count=_products.length;
    // });
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title),
        bottom: _createProgressIndicator(),
        actions: <Widget>[
          dropdownWidget(),
        ],
      ),
      body:
      ListView.builder(
        itemCount: _products.length,
        controller: _scrollController,
        itemBuilder: (context, index) => ProductsTile(_products[index]),
        /*{
          return ListTile(
            title: Text(_products[index]),
          );
        },*/
      ),
      /*
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.0),
              children: _listViewData.reversed.map((data){
                return ListTile(
                  title: Text(data),
                  );
              }).toList(),
              ),
            ),
        ],
        //child: Text(_currentlySelected),
      ),
      */
    );
  }


  Widget dropdownWidget() {
    return DropdownButton(
      items: _dropdownValues
          .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
          .toList(),
      onChanged: (String value) {
        setState(() {
          _currentlySelected = value;
        });
      },
      isExpanded: false,
      value: _dropdownValues.first,
    );
  }

   List<Product> getProductList()
  {
      List<Product> productlist=List<Product>();
      helper.initializedb().then((result)=>helper.getProductListDb().then((result){
      int count=result.length;
      for(int i=0;i<count;i++){
      productlist.add(Product.fromObject(result[i]));}
      if(productlist.length == 0)
      listenForProducts();
      else
      {
        setState(() {
          _products=productlist;
        });
      } 
    }));
    return productlist;
  }

  @override 
  void initState(){
    super.initState();
    getProductList();
    _scrollController.addListener(() {
    });
  }

  @override 
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  void listenForProducts() async {
    final Stream<Product> stream = await getProducts();
    stream.listen((Product products) {
      setState(() => _products.add(products));},
      onDone: (){
        helper.addAllProduct(_products);
      }
      );
    
  }

  
  PreferredSize _createProgressIndicator() => PreferredSize(
  preferredSize: Size(double.infinity, 4.0),
  child: SizedBox(
    height: 4.0,
    child: LinearProgressIndicator()
  )
);

}