import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class WorldController extends ChangeNotifier {
  HomePageNewsModel worldnewsLists = HomePageNewsModel();
  DataState worldDataState = DataState.initial;

  int? categoryIndex = 0;
  getCategoryIndex({givenIndex}) {
    categoryIndex = givenIndex;
    notifyListeners();
  }

  getCategoryData({countryname, categoryName}) async {
    worldDataState = DataState.loading;
    try {
      Response categorydata = await getHttp(
        path: Urls.categoryData(category: categoryName, country: countryname),
      );
      if (categorydata.statusCode == 200) {
        worldnewsLists = HomePageNewsModel.fromJson(categorydata.data);
        worldDataState = DataState.loaded;
      }
    } catch (e) {
      worldDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
