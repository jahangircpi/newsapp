import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class SearchController extends ChangeNotifier {
  HomePageNewsModel searchDataLists = HomePageNewsModel();
  DataState searchDataState = DataState.initial;

  int homeImageIndex = 0;

  getHomeIndex({givenIndex}) {
    homeImageIndex = givenIndex;
    notifyListeners();
  }

  getSearchData({required searchTexts}) async {
    searchDataState = DataState.loading;
    try {
      Response categorydata = await getHttp(
        path: Urls.search(searchText: searchTexts),
      );
      if (categorydata.statusCode == 200) {
        searchDataLists = HomePageNewsModel.fromJson(categorydata.data);
        searchDataState = DataState.loaded;
      }
    } catch (e) {
      searchDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
