import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/home_page_news_model.dart';

class FavoriteController extends ChangeNotifier {
  List<Article>? saveArticle = <Article>[];
  bool isSaved = false;
  addingtoLists({required Article newsItem}) {
    if (saveArticle!
        .indexWhere((element) => element.title == newsItem.title)
        .isNegative) {
      isSaved = true;
      saveArticle!.add(newsItem);
    } else {
      saveArticle!.remove(newsItem);
    }
    notifyListeners();
  }
}
