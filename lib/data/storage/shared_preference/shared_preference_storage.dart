import 'package:infinite_scroll/infrastructure/dto/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStorage {
  static final SharedPreferenceStorage _instance =
      SharedPreferenceStorage._internal();

  factory SharedPreferenceStorage() {
    return _instance;
  }

  SharedPreferenceStorage._internal();

  late final SharedPreferences _prefs;

  bool _isInit = false;

  Future<void> initPrefs() async {
    if (_isInit) {
      return;
    }
    _isInit = true;
    _prefs = await SharedPreferences.getInstance();
  }

  void setTopHeadlineNews(List<News> data) {
    _prefs.setString('topHeadlineNews', data.toString());
  }

  List<News> getTopHeadlineNews() {
    return _prefs.getString('topHeadLineNews') as List<News>;
  }
}
