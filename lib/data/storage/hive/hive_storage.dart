import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';

const _topHeadlineNews = 'topHeadlineNews';
const _sportNews = 'sportNews';
const _bbcNews = 'bbcNews';

class HiveStorage {
  static final HiveStorage _instance = HiveStorage._internal();

  factory HiveStorage() {
    return _instance;
  }

  HiveStorage._internal();

  late final Box _mainStorage = Hive.box(HiveBoxNameUtils.mainStorage);

  Future<void> saveTopHeadlineNews(List<News> news) async {
    await _mainStorage.put(_topHeadlineNews, news);
  }

  Future<List<News>> getTopHeadlineNews() async {
    log('line 26');
    return await _mainStorage.get(_topHeadlineNews);
  }

  Future<void> saveSportNews(List<News> news) async {
    await _mainStorage.put(_sportNews, news);
  }

  Future<List<News>> getSportNews() async {
    List<News> data = [];
    data = await _mainStorage.get(_sportNews);
    return data;
  }

  Future<void> saveBBCNews(List<News> news) async {
    await _mainStorage.put(_bbcNews, news);
  }

  Future<List<News>> getBBCNews() async {
    List<News> data = [];
    data = await _mainStorage.get(_bbcNews);
    return data;
  }

  Future<void> clearStorage() async => await _mainStorage.clear();
}

class HiveBoxNameUtils {
  const HiveBoxNameUtils._();

  static const String mainStorage = "open_hive_storage";
}
