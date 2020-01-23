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

  test('Returns 42 items', () async {
    final response = await http.get(url);
    var itemCount = response.body
        .split('},') // split the text into an array
        .toList()
        .length;
    expect(42, itemCount);
  });

  test('Test for every field returns no null in Products table', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    expect(25, data['Products'].length);
    for (int i = 0; i < data['Products'].length; i++) {
      expect(15, data['Products'][i].length);
      for (int j = 0; j < data['Products'][i].length; j++) {
        expect(true, data['Products'][j]['Category'] != null ? true : false);
        expect(true, data['Products'][j]['Image'] != null ? true : false);
        expect(true, data['Products'][j]['Inventory'] != null ? true : false);
        expect(true, data['Products'][j]['LongDescription'] != null ? true : false);
        expect(true, data['Products'][j]['Price'] != null ? true : false);
        expect(true, data['Products'][j]['ProductId'] != null ? true : false);
        expect(true, data['Products'][j]['ProductName'] != null ? true : false);
        expect(true, data['Products'][j]['ProductVideo'] != null ? true : false);
        expect(true, data['Products'][j]['Rating'] != null ? true : false);
        expect(true, data['Products'][j]['Review'] != null ? true : false);
        expect(true, data['Products'][j]['ShortDescription'] != null ? true : false);
        expect(true, data['Products'][j]['Thumbnail'] != null ? true : false);
        expect(true, data['Products'][j]['FAQ'] != null ? true : false);
        expect(true, data['Products'][j]['Latitude'] != null ? true : false);
        expect(true, data['Products'][j]['Longitude'] != null ? true : false);
      }
    }
  });

  test('Test for every field returns no null in Place table', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    expect(6, data['Place'].length);
    for (int i = 0; i < data['Place'].length; i++) {
      expect(5, data['Place'][i].length);
      for (int j = 0; j < data['Place'][i].length; j++) {
        expect(true, data['Place'][j]['Name'] != null ? true : false);
        expect(true, data['Place'][j]['Image'] != null ? true : false);
        expect(true, data['Place'][j]['ShortDescription'] != null ? true : false);
        expect(true, data['Place'][j]['Latitude'] != null ? true : false);
        expect(true, data['Place'][j]['Longitude'] != null ? true : false);
      }
    }
  });

  test('Test for total users present in database', () async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    var data = json.decode(response.body);
    expect(8, data['Users'].length);
  });
}