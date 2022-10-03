import 'package:hive_flutter/hive_flutter.dart';

class KvHolder {
  static const _defaultKvName = "default";
  static final KvHolder _instance = KvHolder._init();

  factory KvHolder() => _instance;

  KvHolder._init();

  final Map<String, Kv> _kvMap = {};

  Future<void> init({List<String>? names}) async {
    await Hive.initFlutter();
    await Hive.openBox(_defaultKvName);
    if (names != null) {
      names.remove(_defaultKvName);
      for (var value in names) {
        await Hive.openBox(value);
      }
    }
  }

  Kv getKv({String name = _defaultKvName}) {
    if (_kvMap.containsKey(name)) return _kvMap[name]!;
    var box = Hive.box(name);
    var kv = BoxKv(box);
    _kvMap[name] = kv;
    return kv;
  }

  void close() {
    Hive.close();
  }
}

abstract class Kv<E> {
  Future<void> put(dynamic key, E value);

  Future<void> putAll(Map<dynamic, E> entries);

  E? get(dynamic key, {E? defaultValue});

  List<E> getAll();

  Future<void> delete(dynamic key);

  Future<void> deleteAll(Iterable<dynamic> keys);

  bool containsKey(dynamic key);

  Future<void> close();
}

class BoxKv<E> implements Kv {
  late Box _box;

  BoxKv(this._box);

  @override
  Future<void> put(key, value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> putAll(Map entries) async {
    await _box.putAll(entries);
  }

  @override
  get(key, {defaultValue}) => _box.get(key, defaultValue: defaultValue);

  @override
  List getAll() => _box.values.toList();

  @override
  Future<void> delete(key) async {
    await _box.delete(key);
  }

  @override
  Future<void> deleteAll(Iterable keys) async {
    await _box.deleteAll(keys);
  }

  @override
  bool containsKey(key) => _box.containsKey(key);

  @override
  Future<void> close() async {
    await _box.close();
  }
}
