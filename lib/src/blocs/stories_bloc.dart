import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _items = BehaviorSubject<int>();

  Stream<Map<int, Future<ItemModel>>> items;

  // Getters to Streams
  Stream<List<int>> get topIds => _topIds.stream;

  // Getters in Sink
  get fetchItem => _items.sink.add;

  StoriesBloc() {
    items = _items.stream.transform(_itemTransformer());
  }

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _itemTransformer() {
    return ScanStreamTransformer(
      (Map<int, Future<ItemModel>> cache, int id, _) {
        cache[id] = _repository.fetchItem(id);
        return cache;
      },
      <int, Future<ItemModel>>{}
    );
  }

  dispose() {
    _topIds.close();
    _items.close();
  }
}