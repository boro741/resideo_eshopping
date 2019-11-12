import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resideo eshopping',
      theme: ThemeData(
        primaryColor: Color(0xff11b719),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text("Screen 3",
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
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: const Icon(
                  FontAwesomeIcons.phone,
                  color: Color(0xff11b719),
                ),
                hintText: 'Ex: +91-9700000000',
                labelText: 'Phone',
              ),
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
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 150.0,
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
