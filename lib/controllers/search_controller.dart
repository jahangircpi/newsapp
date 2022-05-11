import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class SearchController extends ChangeNotifier {
  HomePageNewsModel searchDataLists = HomePageNewsModel();
  DataState categoryDataState = DataState.initial;

  getSearchData({required searchTexts}) async {
    categoryDataState = DataState.loading;
    try {
      Response categorydata = await getHttp(
        path: Urls.search(searchText: searchTexts),
      );
      if (categorydata.statusCode == 200) {
        categoryDataState = DataState.loaded;
        searchDataLists = HomePageNewsModel.fromJson(categorydata.data);
        categoryDataState = DataState.loaded;
      }
    } catch (e) {
      categoryDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
