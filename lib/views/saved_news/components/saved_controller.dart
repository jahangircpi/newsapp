import 'package:flutter/cupertino.dart';

import '../../../models/home_page_news_model.dart';

class SavedController extends ChangeNotifier {
  List<Article>? savednewsLists = [];

  addingtoLists({title}) {
    savednewsLists!.indexWhere((element) => element.title == title);
  }
}
