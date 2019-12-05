import 'dart:convert';
import 'dart:io';
import 'package:resideo_eshopping/model/product.dart';
//import 'package:http/http.dart' as http;
import 'dart:async';

/*
Future<Stream<Product>> getProducts() async {
  final String url = 'https://fluttercheck-5afbb.firebaseio.com/.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1';
 
  final client = http.Client();
  final streamedRest = await client.send(
    http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
    .transform(utf8.decoder)
    .transform(json.decoder)
    .expand((data) => (data as List))
    .map((data) => Product.fromJSON(data));

  
}*/

Future<Stream<Product>> getProducts() async {
  final String url = 'https://fluttercheck-5afbb.firebaseio.com/Products.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1';
  try{
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    if(response.statusCode == 200){
      return response
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Product.fromJSON(data));
    }
    else{
      throw Exception("Error");
    }
  } 
  catch(exception){
    print(exception.toString());
  }

}
