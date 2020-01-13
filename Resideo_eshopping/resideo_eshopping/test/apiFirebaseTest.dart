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

  test('Returns 36 items', () async {
    final response = await http.get(url);
    var itemCount = response.body
        .split('},') // split the text into an array
        .toList()
        .length;

    expect(38, itemCount);
  });

  test('Test for every field returns no null', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    expect(true, data['Products'][0]['Category'] != null ? true : false);
    expect(true, data['Products'][0]['Image'] != null ? true : false);
    expect(true, data['Products'][0]['Inventory'] != null ? true : false);
    expect(true, data['Products'][0]['LongDescription'] != null ? true : false);
    expect(true, data['Products'][0]['Price'] != null ? true : false);
    expect(true, data['Products'][0]['ProductId'] != null ? true : false);
    expect(true, data['Products'][0]['ProductName'] != null ? true : false);
    expect(true, data['Products'][0]['ProductVideo'] != null ? true : false);
    expect(true, data['Products'][0]['Rating'] != null ? true : false);
    expect(true, data['Products'][0]['Review'] != null ? true : false);
    expect(true, data['Products'][0]['ShortDescription'] != null ? true : false);
    expect(true, data['Products'][0]['Thumbnail'] != null ? true : false);
    expect(true, data['Products'][0]['FAQ'] != null ? true : false);
  });

  test('An Object contains 11 fields', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);

    expect(15, data['Products'][0].length);
  });
}