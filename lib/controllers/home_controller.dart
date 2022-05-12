import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class HomeController extends ChangeNotifier {
  HomePageNewsModel homedataLists = HomePageNewsModel();
  DataState homeDataState = DataState.initial;

  int? popularItemIndex = 0;
  getPopularItemIndex({indexGiven}) {
    popularItemIndex = indexGiven;
    notifyListeners();
  }

  getHomeData({required newswebsite}) async {
    homeDataState = DataState.loading;
    try {
      Response data = await getHttp(
        path: Urls.homeapi(website: newswebsite),
      );
      if (data.statusCode == 200) {
        homedataLists = HomePageNewsModel.fromJson(data.data);
        homeDataState = DataState.loaded;
      }
    } catch (e) {
      homeDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
