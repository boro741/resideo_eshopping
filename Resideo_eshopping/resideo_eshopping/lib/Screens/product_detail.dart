import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resideo_eshopping/model/eshopping_model.dart';
import 'package:resideo_eshopping/Screens/addUserDetails.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}

class ProductDetail extends StatelessWidget
{
 
  Product pd;
  ProductDetail(this.pd);
  bool _buttonDisabled=false;
  @override
  Widget build(BuildContext context) {
    void navigateToCustomerAddress() async{
     Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserDetails(pd)));
  }
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Resideo e-Shopping"),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Text(pd.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
                   Spacer(),
                   StarDisplay(value: pd.rating,),
             
                ],
                ),
                Text(pd.sDesc),
                SizedBox(height: 20,),
                Image.network(pd.img),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Icon(FontAwesomeIcons.rupeeSign),
                   Text(pd.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                   Spacer(),
                   _getInventory(pd.quantity),     
                ],
                ),
                SizedBox(height: 20,),
                MaterialButton(
                  textColor: Colors.white,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(),
                  color: Colors.blue,
                  disabledColor: Colors.blueGrey,
                  disabledTextColor: Colors.black,
                  child: Text("Order Now",style: TextStyle(fontSize: 20),),
                  onPressed: _buttonDisabled? null:(){navigateToCustomerAddress();
                  },
                ),
                SizedBox(height: 20,),
                Text("About This Item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10,),
                Text(pd.lDesc,style: TextStyle(fontSize: 15),),
                SizedBox(height: 20,),
                Text('Customer Reviews',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10,),
                Text(pd.review,style: TextStyle(fontSize: 15),)
                      
          ],
        ),
          ],
        )
      ),
    );
    
  }
  
  dynamic _getInventory(int quantity){

    if(quantity <=0){
    _buttonDisabled=true;
    return  Text("Out of Stock",style: TextStyle(color: Colors.red,) );
    }
    else
    if (quantity<5)
    return  Text("Only $quantity left",style: TextStyle(color: Colors.red,) );
    else
    return  Text("In Stock",style: TextStyle(color: Colors.green,) );
  }

  
}