import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import '../models/home_page_news_model.dart';
import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class WorldController extends ChangeNotifier {
  HomePageNewsModel worldnewsLists = HomePageNewsModel();
  DataState categoryDataState = DataState.initial;

  int? categoryIndex = 0;
  getCategoryIndex({givenIndex}) {
    categoryIndex = givenIndex;
    notifyListeners();
  }

  getCategoryData({countryname, categoryName}) async {
    categoryDataState = DataState.loading;
    try {
      Response categorydata = await getHttp(
        path: Urls.categoryData(category: categoryName, country: countryname),
      );
      if (categorydata.statusCode == 200) {
        categoryDataState = DataState.loaded;
        worldnewsLists = HomePageNewsModel.fromJson(categorydata.data);
        categoryDataState = DataState.loaded;
      }
    } catch (e) {
      categoryDataState = DataState.error;
      printer(e);
    }
    notifyListeners();
  }
}

// getCategoryData({countryname, categoryName}) async {
//   categoryDataState = DataState.loading;
//   try {
//     Response categorydata = await getHttp(
//       path: Urls.categoryData(category: categoryName, country: countryname),
//     );
//     if (categorydata.statusCode == 200) {
//       categoriesLists = Category.fromJson(categorydata.data);
//       categoryDataState = DataState.loaded;
//       printer(categoriesLists.articles);
//     }
//   } catch (e) {
//     categoryDataState = DataState.error;
//     printer(e);
//   }
//   notifyListeners();
// }
