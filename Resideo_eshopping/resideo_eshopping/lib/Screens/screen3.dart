import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Screen3 extends StatelessWidget {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  // Estimated cost of product to be sent from the previous page
  Screen3(@required this.estimatedCost);
  final double estimatedCost;

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        //Todo: Do Something
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        //Todo: Do Something
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Order Confrimation"),
      content: Text("Do you want to proceed?"),
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
          child: Text("Add User Details",
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: Form(
        key: _formKeyValue,
        autovalidate: true,
        child: new ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  FontAwesomeIcons.userCircle,
                  color: Color(0xff11b719),
                ),
                hintText: 'Enter your Name',
                labelText: 'Name',
              ),
              validator: (val) {
                if (val.length == 0) {
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
                  color: Color(0xff11b719),
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
                  color: Color(0xff11b719),
                ),
                labelText: 'Address',
              ),
              validator: (val) {
                if (val.length == 0)
                  return 'Address Field should not be empty';
                else
                  return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  FontAwesomeIcons.mapMarker,
                  color: Color(0xff11b719),
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
                        color: Color(0xff11b719)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Text(
                    'Rs. $estimatedCost',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                RaisedButton(
                    color: Color(0xff11b719),
                    textColor: Colors.white,
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("Proceed", style: TextStyle(fontSize: 24.0)),
                          ],
                        )),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
