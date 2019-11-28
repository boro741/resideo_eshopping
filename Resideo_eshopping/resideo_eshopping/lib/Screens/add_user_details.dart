import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/Screens/product_list_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resideo_eshopping/controller/product_controller.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class AddUserDetails extends StatelessWidget {
  static GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  
  AddUserDetails(this.product);
  final Product product;
  final ProductController productController=ProductController();
  
void navigateToHomePage(BuildContext context) async{
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    ProductsListPage(title: 'Resideo e-Shopping')), (Route<dynamic> route) => false);
  }

  orderPlaced(BuildContext context){

    PlatformAlertDialog alert = PlatformAlertDialog(
      /*
      title: Text("Order Placed"),
      content: Text("Thank you for placing order"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: (){           
             navigateToHomePage(context);
          },
        )
      ],*/
    );
  
/*
    showDialog(context: context,
    builder: (BuildContext context){
      return alert;
    });
*/
    showDialog(
  context: context,
  builder: (_) => NetworkGiffyDialog(
    image: Image.asset('assets/images/tenor.gif'),
    title: Text('Order Placed!!',
            textAlign: TextAlign.center,
            style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w600)),
    description: Text("Thank you for placing order"),
            onOkButtonPressed: () {
              _formKeyValue = new GlobalKey<FormState>();
             navigateToHomePage(context);
            },
  ) );
    return alert;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = PlatformButton(
      child: PlatformText("No"),
      onPressed: () {
        Navigator.pop(context);
      },
      androidFlat: (_) => MaterialFlatButtonData()
    );
    Widget continueButton = PlatformButton(
      child: PlatformText("Yes"),
      onPressed: () {
         Navigator.pop(context);
         productController.updateInventory(product);
           orderPlaced(context);},
      androidFlat: (_) => MaterialFlatButtonData() 
    );

    // set up the AlertDialog
    PlatformAlertDialog alert = PlatformAlertDialog(
      title: PlatformText("Order Confrimation"),
      content: PlatformText("Do you want to place order?"),
      actions: <Widget>[
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Container(
          alignment: Alignment.center,
          child: PlatformText("Resideo e-Shopping",
              style: TextStyle(
                //color: Colors.white,
              )),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.userCircle,
                          color: Colors.blue,
                        ),
                        hintText: 'Enter your Name',
                        labelText: 'Name',
                      ),
                      validator: (val) {
                        if (val.isEmpty) {
                          return 'Name field should not be empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.phone,
                          color: Colors.blue,
                        ),
                        hintText: 'Ex: 9700000000',
                        labelText: 'Phone',
                      ),
                      validator: (val) {
                        Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(val))
                          return 'Enter Valid Phone Number';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.home,
                          color: Colors.blue,
                        ),
                        labelText: 'Address',
                      ),
                      validator: (val) {
                        if (val.isEmpty)
                          return 'Address Field should not be empty';
                        else
                          return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(
                          FontAwesomeIcons.mapMarker,
                          color: Colors.blue,
                        ),
                        hintText: 'Ex: 500000',
                        labelText: 'Zip Code',
                      ),
                      validator: (val) {
                        Pattern pattern = r'^[1-9][0-9]{5}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(val))
                          return 'Enter Valid ZipCode';
                        else
                          return null;
                      },
                      keyboardType: TextInputType.number,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          child: Text(
                            'Estimated Price: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20.0),
                          child: PlatformText(
                            'Rs. ' + product.price.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        color: Colors.blue,
                        textColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text("Proceed",
                                    style: TextStyle(fontSize: 24.0)),
                              ],
                            )),
                        onPressed: () {
                          if (_formKeyValue.currentState.validate()) {
                           
                            showAlertDialog(context);                            
                          }
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}