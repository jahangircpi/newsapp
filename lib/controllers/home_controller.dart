import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/views/home/components/utilities/apikeyslists.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';
import '../views/home/components/utilities/allpopularnewswebsite.dart';

class HomeController extends ChangeNotifier {
  HomePageNewsModel homedataLists = HomePageNewsModel();
  DataState homeDataState = DataState.initial;
  List<Article>? articlesLists = [];

  int? popularItemIndex = 0;

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

  DateTime dateNow = DateTime.now();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

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

  getMoreTask({required newswebsite, fromdate, todate, pagees}) async {
    var timeNowFrom = DateTime(dateNow.year, dateNow.month - 1, dateNow.day)
        .toString()
        .split(' ')[0];
    var timeNowTo = DateTime.now().toString().split(' ')[0];
    homeDataState = DataState.isMoreDatAvailable;
    notifyListeners();
    try {
      await getHttp(
        path: Urls.homeapi(
            website: newswebsite,
            from: fromdate ?? timeNowFrom,
            to: fromdate ?? timeNowTo,
            page: pagees),
      ).then((value) {
        for (int i = 0; i < value.data['articles'].length; i++) {
          articlesLists!.add(Article.fromJson(value.data['articles'][i]));
        }
      });
      homeDataState = DataState.loaded;
    } catch (e) {
      homeDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }

  getHomeData({required newswebsite, fromdate, todate}) async {
    homeDataState = DataState.loading;
    notifyListeners();
    var timeNowFrom = DateTime(dateNow.year, dateNow.month - 1, dateNow.day)
        .toString()
        .split(' ')[0];
    var timeNowTo = DateTime.now().toString().split(' ')[0];

    try {
      await getHttp(
        path: Urls.homeapi(
            website: newswebsite,
            from: fromdate ?? timeNowFrom,
            to: fromdate ?? timeNowTo,
            page: 1),
      ).then((value) {
        articlesLists!.clear();
        for (int i = 0; i < value.data['articles'].length; i++) {
          articlesLists!.add(Article.fromJson(value.data['articles'][i]));
        }
      });
      homeDataState = DataState.loaded;
    } catch (e) {
      homeDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}
