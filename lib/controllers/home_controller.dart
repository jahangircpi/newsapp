import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class HomeController extends ChangeNotifier {
  HomePageNewsModel homedataLists = HomePageNewsModel();
  DataState categoryDataState = DataState.initial;

  int? popularItemIndex = 0;
  getPopularItemIndex({indexGiven}) {
    popularItemIndex = indexGiven;
    notifyListeners();
  }

  getHomeData({required newswebsite}) async {
    categoryDataState = DataState.loading;
    try {
      Response categorydata = await getHttp(
        path: Urls.homeapi(website: newswebsite),
      );
      if (categorydata.statusCode == 200) {
        categoryDataState = DataState.loaded;
        homedataLists = HomePageNewsModel.fromJson(categorydata.data);
        categoryDataState = DataState.loaded;
      }
    } catch (e) {
      categoryDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
