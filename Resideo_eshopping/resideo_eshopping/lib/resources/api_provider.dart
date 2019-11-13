import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:resideo_eshopping/model/item_model.dart';

class ApiProvider {
  Client client = Client();
  fetchProduct() async {
    final response = await client.get(
        "https://fluttercheck-5afbb.firebaseio.com/1.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1");
    ItemModel itemModel = ItemModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}
