import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:resideo_eshopping/model/product.dart';
import 'package:resideo_eshopping/Screens/add_user_details.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';

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

class ProductDetail extends StatefulWidget
{
 
  final Product pd;
  ProductDetail(this.pd);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool buttonDisabled=false;

  String inventoryDetail;

  VideoPlayerController _videoPlayerController;

  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.pd.pVideo);
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
    _videoPlayerController.setLooping(true);
    _videoPlayerController.setVolume(1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void navigateToCustomerAddress() async{
     Navigator.push(context, MaterialPageRoute(builder: (context)=> AddUserDetails(widget.pd)));
  }
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText("Resideo e-Shopping"),
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
                   Text(widget.pd.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.blue),),
                   Spacer(),
                   StarDisplay(value: widget.pd.rating,),
             
                ],
                ),
                Text(widget.pd.sDesc),
                SizedBox(height: 20,),
                //Image.network(pd.img),
        
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child:
                          CarouselSlider(
                            height: 300.0,
                            items: [
                              Image.network(widget.pd.img, fit: BoxFit.fill,),
                              VideoPlayer(_videoPlayerController),
                            ],
                          ), 
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      if (_videoPlayerController.value.isPlaying) {
                        _videoPlayerController.pause();
                      } else {
                        _videoPlayerController.play();
                      }
                    });
                  },
                  child: Icon(
                    _videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  ),
                ), 
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                   Icon(FontAwesomeIcons.rupeeSign),
                   Text(widget.pd.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                   Spacer(),
                   getInventory(widget.pd.quantity),     
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
                  onPressed: buttonDisabled? null:(){navigateToCustomerAddress();
                  },
                ),
                SizedBox(height: 20,),
                Text("About This Item",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10,),
                Text(widget.pd.lDesc,style: TextStyle(fontSize: 15),),
                SizedBox(height: 20,),
                Text('Customer Reviews',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                SizedBox(height: 10,),
                Text(widget.pd.review,style: TextStyle(fontSize: 15),),

                SizedBox(height: 20,),            
          ],
        ),
          ],
        )
      ),
    );
    
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    super.dispose();
  }

  dynamic getInventory(int quantity){

    if(quantity <=0){
    buttonDisabled=true;
    inventoryDetail="Out of Stock";
    return  Text(inventoryDetail,style: TextStyle(color: Colors.red,) );
    }
    else
    if (quantity<5){
    inventoryDetail="Only $quantity left";
    return  Text(inventoryDetail,style: TextStyle(color: Colors.red,) );
    }
    else{
    inventoryDetail="In Stock";
    return  Text(inventoryDetail,style: TextStyle(color: Colors.green,) );
    }
  }
}