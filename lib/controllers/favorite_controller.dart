import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/services/sharedpreference_service.dart';

class FavoriteController extends ChangeNotifier {
  List<Article> saveArticle = <Article>[];

  addingtoLists({required Article newsItem}) {
    if (saveArticle
        .indexWhere((element) => element.title == newsItem.title)
        .isNegative) {
      saveArticle.add(newsItem);
      final String encodedData = Article.encode(saveArticle);
      StorageManager.saveData('savedlists', encodedData);
      notifyListeners();
    } else {
      saveArticle.remove(newsItem);
      final String encodedData = Article.encode(saveArticle);
      StorageManager.saveData('savedlists', encodedData);
      notifyListeners();
    }
    notifyListeners();
  }
}
