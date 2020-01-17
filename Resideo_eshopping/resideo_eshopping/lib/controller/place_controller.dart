import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:resideo_eshopping/model/places.dart';

Future<Stream<Place>> getPlaces() async {
  final String url = 'https://fluttercheck-5afbb.firebaseio.com/Place.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1';

  final client = new http.Client();
  final streamedRest = await client.send(
      http.Request('get', Uri.parse(url))
  );

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Place.fromJSON(data));
}