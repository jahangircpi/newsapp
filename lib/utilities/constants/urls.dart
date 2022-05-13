import 'package:newsapp/controllers/home_controller.dart';

class Urls {
  static String apiKey = HomeController().apikey!;
  static const baseUrl = 'https://newsapi.org/v2/';
  static String categoryData({country, category}) =>
      "$baseUrl${"/top-headlines?country=$country&category=$category&apiKey=$apiKey"}";
  static String homeapi({website, from, to}) =>
      "$baseUrl/everything?domains=$website&language=en&from=$from&to=$to&apiKey=$apiKey";
  static String search({searchText}) =>
      "$baseUrl${"/everything?q=$searchText&sortBy=relevancy&apiKey=$apiKey"}";
}
