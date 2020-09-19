import 'package:SD_Times/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fetch Top Ids', () async {
    final newsAPI = NewsApiProvider();
    newsAPI.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });
    final ids = await newsAPI.fetchTopIds();
    expect(ids, [1, 2, 3, 4]);
  });
  test('FetchItem return a item model', () async {
    final newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });
    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}