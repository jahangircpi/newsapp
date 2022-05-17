import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/constants/themes.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/widgets/search_bar.dart';
import 'package:newsapp/views/saved_news/components/alldata.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  List<Article> searchArticleLists = <Article>[];
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    callBack(() async {
      searchArticleLists = context.read<FavoriteController>().saveArticle;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Consumer<FavoriteController>(
          builder: ((context, favoritecontroller, child) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: PThemes.padding),
              child: Column(
                children: [
                  appBar(context),
                  gapY(8),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(4),
                    ),
                    child: searchField(
                        hintText: 'Search',
                        onChanged: (v) {
                          searchArticleLists = favoritecontroller.saveArticle
                              .where((element) => element.title!
                                  .toString()
                                  .toLowerCase()
                                  .contains(v))
                              .toList();
                          setState(() {});
                        }),
                  ),
                  gapY(8),
                  Expanded(
                    child: AllSavedDataLists(
                        listName: searchArticleLists,
                        favoritecontroller: favoritecontroller),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    return Text(
      'Saved Articles',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: UdDesign.fontSize(20),
      ),
    );
  }
}
