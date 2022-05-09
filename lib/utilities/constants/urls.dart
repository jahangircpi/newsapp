class Urls {
  static const baseUrl = 'https://newsapi.org/v2/';

  static String categoryData({country, category}) =>
      "$baseUrl${"top-headlines?$country=au&category=$category&apiKey=8454ed8e9a2b418d8227098efe5e343b"}";
}

String aname = 'jahangir';
