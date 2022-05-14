import 'package:newsapp/controllers/home_controller.dart';

class Urls {
  static String apiKey = HomeController().apikey!;
  static const baseUrl = 'https://newsapi.org/v2/';
  static String categoryData({country, category, page}) =>
      "$baseUrl${"/top-headlines?country=$country&category=$category&page=$page&apiKey=$apiKey"}";
  static String homeapi({website, from, to, page}) =>
      "$baseUrl/everything?domains=$website&language=en&page=$page&from=$from&to=$to&apiKey=$apiKey";
  static String search({
    searchText,
  }) =>
      "$baseUrl${"/everything?q=$searchText&sortBy=relevancy&apiKey=$apiKey"}";
}
