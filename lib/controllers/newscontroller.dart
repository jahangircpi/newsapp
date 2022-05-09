// import '../models/categorymodel.dart';
// import '../models/headlinemodel.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapp/models/categorymodel.dart';

import '../utilities/constants/urls.dart';
import '../utilities/functions/print.dart';
import '../utilities/services/dio_services.dart';

class NewsController extends ChangeNotifier {
  Category categoriesLists = Category();

  getCategoryData({countryname, categoryName}) async {
    Response categorydata = await getHttp(
      path: Urls.categoryData(country: countryname, category: categoryName),
    );
    categoriesLists = Category.fromJson(categorydata.data);
    printer(categoriesLists.totalResults);
    notifyListeners();
  }
}


// class NewsApi {
//   var link =
//       "https://newsapi.org/v2/top-headlines?country=us&apiKey=8454ed8e9a2b418d8227098efe5e343b";
//   var link2 =
//       "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=8454ed8e9a2b418d8227098efe5e343b";
//   Future fetchdata() async {
//     var response = await http.get(Uri.parse(link));
//     if (response.statusCode == 200) {
//       return newsFromJson(response.body);
//     } else {
//       throw Exception("Api has problems to load");
//     }
//   }

//   Future fetchdata2({category, country}) async {
//     var response = await http.get(Uri.parse(
//         "https://newsapi.org/v2/top-headlines?country=au&category=business&apiKey=8454ed8e9a2b418d8227098efe5e343b"));
//     if (response.statusCode == 200) {
//       return categoryFromJson(response.body);
//     } else {
//       throw Exception("Api has problems to load");
//     }
//   }

//   Future fetchdata3(
//     country,
//   ) async {
//     var response = await http.get(Uri.parse(
//         "https://newsapi.org/v2/top-headlines?country=$country&category=business&apiKey=8454ed8e9a2b418d8227098efe5e343b"));
//     if (response.statusCode == 200) {
//       return categoryFromJson(response.body);
//     }
//   }
// }
