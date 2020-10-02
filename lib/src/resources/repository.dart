import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository {
  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider(),
  ];
  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  Future<List<int>> fetchTopIds() {
    return sources[1].fetchTopIds();
  }

  Future<List<int>> fetchNewestIds() {
    return sources[1].fetchNewestIds();
  }

  Future<List<int>> fetchBestIds() {
    return sources[1].fetchBestIds();
  }

  Future<List<int>> fetchJobIds() {
    return sources[1].fetchJobIds();
  }

  Future<List<int>> fetchQuestionIds() {
    return sources[1].fetchQuestionIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (cache != source) {
        cache.addItem(item);
      }
    }

    return item;
  }

  clearCache() async {
    for (var cache in caches) {
      await cache.clear();
    }
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<List<int>> fetchNewestIds();
  Future<List<int>> fetchBestIds();
  Future<List<int>> fetchJobIds();
  Future<List<int>> fetchQuestionIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}