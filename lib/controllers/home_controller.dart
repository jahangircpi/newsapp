import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/views/home/components/apikeyslists.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';
import '../views/home/components/allpopularnewswebsite.dart';

class HomeController extends ChangeNotifier {
  HomePageNewsModel homedataLists = HomePageNewsModel();
  DataState homeDataState = DataState.initial;

  int? popularItemIndex = 0;
  DateTime dateNow = DateTime.now();
  var timeNow = DateTime.now().toString().split(' ')[0];

  String? selectNewsPaper = popularwebsiteLists[0].title!;
  String? apikey = apikeyslists2[0].title!;
  updateapikey({key}) {
    apikey = key;
    notifyListeners();
  }

  updateNewsPaper({newspaper}) {
    selectNewsPaper = newspaper;
    notifyListeners();
  }

  var fromDate;
  var toDate;

  updateDate({fromdate, fromorto}) {
    if (fromorto == 'fromfunction') {
      fromDate = fromdate;
    } else {
      toDate = fromdate;
    }
    notifyListeners();
  }

  getPopularItemIndex({indexGiven}) {
    popularItemIndex = indexGiven;
    notifyListeners();
  }

  getHomeData({required newswebsite, fromdate, todate}) async {
    homeDataState = DataState.loading;
    try {
      Response data = await getHttp(
        path: Urls.homeapi(
            website: newswebsite,
            from: fromdate ?? timeNow,
            to: fromdate ?? timeNow),
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
