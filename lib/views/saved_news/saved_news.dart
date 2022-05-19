import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/constants/themes.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/widgets/search_bar.dart';
import 'package:newsapp/views/saved_news/components/alldata.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/colors.dart';

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
    searchArticleLists = context.read<FavoriteController>().saveArticle;
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
            var set = <dynamic>{};
            List<Article> categorylistTop = favoritecontroller.saveArticle
                .where((element) => set.add(element.source!.name!))
                .toSet()
                .toList();
            categorylistTop.sort((a, b) => a.source!.name!
                .toLowerCase()
                .compareTo(b.source!.name!.toLowerCase()));

            categorylistTop.insert(
              0,
              Article(
                source: Source(id: 'null', name: 'All'),
              ),
            );
            searchArticleLists = searchArticleLists.reversed.toList();
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
                  SizedBox(
                    height: UdDesign.pt(50),
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: categorylistTop.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: UdDesign.pt(4),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              favoritecontroller.getSetelectdIndex(
                                  value: index);
                              if (categorylistTop[index].source!.name ==
                                  'All') {
                                searchArticleLists =
                                    favoritecontroller.saveArticle;
                              } else {
                                searchArticleLists = favoritecontroller
                                    .saveArticle
                                    .where((element) => element.source!.name!
                                        .contains(categorylistTop[index]
                                            .source!
                                            .name!))
                                    .toList();
                              }
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    favoritecontroller.selectIndexcat == index
                                        ? PColors.basicColor
                                        : Colors.white10,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: UdDesign.pt(8),
                                  horizontal: UdDesign.pt(20),
                                ),
                                child: Center(
                                  child: Text(
                                    categorylistTop[index].source!.name!,
                                    style: TextStyle(
                                        fontSize: UdDesign.fontSize(15),
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  gapY(10),
                  Expanded(
                    child: AllSavedDataLists(
                        listName: searchArticleLists,
                        favoritecontroller: favoritecontroller),
                  ),
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
