class Urls {
  static const baseUrl = 'https://newsapi.org/v2/';
  static const everything =
      "$baseUrl/everything?q=bitcoin&apiKey=0aacbc697a864022adbf7c160ca39a02";
  static String categoryData({country, category}) =>
      "$baseUrl${"/top-headlines?country=$country&category=$category&apiKey=8454ed8e9a2b418d8227098efe5e343b"}";
}

String aname = 'jahangir';
