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
        .split('},') // split the text into an array
        .toList()
        .length;

    expect(itemCount, 25);
  });

  test('Test for every field returns no null', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    expect(data[0]['Category'] != null ? true : false, true);
    expect(data[0]['Image'] != null ? true : false, true);
    expect(data[0]['Inventory'] != null ? true : false, true);
    expect(data[0]['LongDescription'] != null ? true : false, true);
    expect(data[0]['Price'] != null ? true : false, true);
    expect(data[0]['ProductId'] != null ? true : false, true);
    expect(data[0]['ProductName'] != null ? true : false, true);
    expect(data[0]['Rating'] != null ? true : false, true);
    expect(data[0]['Review'] != null ? true : false, true);
    expect(data[0]['ShortDescription'] != null ? true : false, true);
    expect(data[0]['Thumbnail'] != null ? true : false, true);
  });

  test('An Object contains 11 fields', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    expect(data[0].length, 11);
  });
}