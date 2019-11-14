import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String url =
    'https://fluttercheck-5afbb.firebaseio.com/.json?auth=fzAIfjVy6umufLgQj9bd1KmgzzPd6Q6hDvj1r3u1';

void main() {
  test('HTTP 200 Ok status code', () async {
    final response = await http.get(url);
    expect(response.statusCode, 200);
  });

  test('Returns 25 items', () async {
    final response = await http.get(url);
    var itemCount = response.body
        .split('}') // split the text into an array
        .toList()
        .length;
    expect(itemCount, 25);
  });
}
