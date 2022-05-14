import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/services/dio_services.dart';

class WorldController extends ChangeNotifier {
  List<Article>? worldnewsLists = [];
  DataState worldDataState = DataState.initial;

  int? categoryIndex = 0;
  getCategoryIndex({givenIndex}) {
    categoryIndex = givenIndex;
    notifyListeners();
  }

  getCategoryData({countryname, categoryName}) async {
    worldDataState = DataState.loading;
    notifyListeners();
    try {
      await getHttp(
        path: Urls.categoryData(
            category: categoryName, country: countryname, page: 1),
      ).then((value) {
        worldnewsLists!.clear();
        for (int i = 0; i < value.data['articles'].length; i++) {
          worldnewsLists!.add(Article.fromJson(value.data['articles'][i]));
        }
      });
      worldDataState = DataState.loaded;
    } catch (e) {
      worldDataState = DataState.error;
    }
    notifyListeners();
  }

  getmoreTask({countryname, categoryName, pages}) async {
    worldDataState = DataState.isMoreDatAvailable;
    notifyListeners();
    try {
      await getHttp(
        path: Urls.categoryData(
            category: categoryName, country: countryname, page: pages),
      ).then((value) {
        for (int i = 0; i < value.data['articles'].length; i++) {
          worldnewsLists!.add(Article.fromJson(value.data['articles'][i]));
        }
      });
      worldDataState = DataState.loaded;
    } catch (e) {
      worldDataState = DataState.error;
    }
    notifyListeners();
  }
  //   getMoreTask({required searchTexts, pagees}) async {
  //   searchDataState = DataState.isMoreDatAvailable;
  //   notifyListeners();
  //   try {
  //     await getHttp(
  //       path: Urls.search(searchText: searchTexts, page: 1),
  //     ).then((value) {
  //       searchDataLists!.clear();
  //       for (int i = 0; i < value.data['articles'].length; i++) {
  //         searchDataLists!.add(Article.fromJson(value.data['articles'][i]));
  //       }
  //     });
  //     searchDataState = DataState.loaded;
  //   } catch (e) {
  //     searchDataState = DataState.error;
  //     printer(e);
  //   }
  //   notifyListeners();
  // }
}
