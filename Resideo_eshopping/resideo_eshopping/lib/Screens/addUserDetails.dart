import 'package:flutter/material.dart';
import 'package:resideo_eshopping/Screens/productsListPage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resideo_eshopping/model/eshopping_model.dart';
import 'package:resideo_eshopping/util/dbhelper.dart';

class AddUserDetails extends StatelessWidget {
  static final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  Dbhelper helper = Dbhelper();
  AddUserDetails(this.pd);
  final Product pd;
  
  int decreaseInventoryCount(){
    if(pd.quantity > 0)
    return (pd.quantity - 1);
    else
    return 0;
  }

void navigateToHomePage(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder:(context)=>ProductsListPage(title: 'Resideo e-Shopping')));
  }

  orderPlaced(BuildContext context){

    AlertDialog alert = AlertDialog(
      title: Text("Order Placed"),
      content: Text("Thank you for placing order"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ok"),
          onPressed: (){
             helper.updateInventoryById(pd.id, decreaseInventoryCount()).then((result)=>  navigateToHomePage(context));
          },
        )
      ],
    );
    showDialog(context: context,
    builder: (BuildContext context){
      return alert;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
         Navigator.pop(context);
         
         orderPlaced(context);
        
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order Confrimation"),
      content: Text("Do you want to place order?"),
      actions: [
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
    
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Resideo e-Shopping",
              style: TextStyle(
                color: Colors.white,
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
                          child: Text(
                            'Rs. ' + pd.price.toString(),
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
