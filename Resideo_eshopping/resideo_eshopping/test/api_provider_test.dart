import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
import '../lib/resources/api_provider.dart';

void main() {
  test("Testing the network call", () async {
    //setup the test
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = {'ProductId': 2};
      return Response(json.encode(mapJson), 200);
    });
    final item = await apiProvider.fetchProduct();
    expect(item.ProductId, 2);
  });
}
