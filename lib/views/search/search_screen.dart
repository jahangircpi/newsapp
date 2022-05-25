import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/utilities/services/sharedpreference_service.dart';
import 'package:newsapp/utilities/widgets/search_bar.dart';
import 'package:newsapp/utilities/widgets/snack_bar.dart';
import 'package:newsapp/utilities/widgets/top_sheet.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../models/home_page_news_model.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/functions/navigations.dart';
import '../../utilities/widgets/contianer_white.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Article>? searchList = [];
  @override
  void initState() {
    super.initState();
    searchList = context.read<SearchController>().searchDataLists.articles!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Consumer<SearchController>(
          builder: ((context, searchcontroller, child) {
            var set = <dynamic>{};
            var categorylistTop = searchcontroller.searchDataLists.articles!
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

            return Column(
              children: [
                gapY(PThemes.padding),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: UdDesign.pt(8),
                  ),
                  child: searchSection(
                      controllerForSearcing:
                          searchcontroller.searchTextController,
                      searchcontroller: searchcontroller,
                      context: context,
                      hinttext: 'Search Anything'),
                ),
                gapY(4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(8),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showTopModalSheet(
                          context: context,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: size.height * 0.12,
                              left: size.width * 0.35,
                              right: size.height * 0.05,
                            ),
                            child: Container(
                              color: PColors.backgrounColor,
                              height: size.height * 0.5,
                              child: Scrollbar(
                                controller:
                                    searchcontroller.sheetScrollController,
                                thumbVisibility: true,
                                child: ListView.builder(
                                  controller:
                                      searchcontroller.sheetScrollController,
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: categorylistTop.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: UdDesign.pt(10),
                                        vertical: UdDesign.pt(8),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (categorylistTop[index]
                                                  .source!
                                                  .name ==
                                              'All') {
                                            searchList = searchcontroller
                                                .searchDataLists.articles;
                                          } else {
                                            searchList = searchcontroller
                                                .searchDataLists.articles!
                                                .where((element) => element
                                                    .source!.name!
                                                    .contains(
                                                        categorylistTop[index]
                                                            .source!
                                                            .name!))
                                                .toList();
                                          }
                                          pop(context: context);
                                          setState(() {});
                                        },
                                        child: Center(
                                          child: Text(
                                            categorylistTop[index]
                                                .source!
                                                .name!,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: UdDesign.fontSize(20),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.filter_alt,
                        color: Colors.white,
                        size: UdDesign.pt(20),
                      ),
                    ),
                  ),
                ),
                gapY(4),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(8),
                    ),
                    child: containerwhite(
                      dataStateEnum: searchcontroller.searchDataState,
                      listName: searchList,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget searchSection(
      {TextEditingController? controllerForSearcing,
      SearchController? searchcontroller,
      BuildContext? context,
      onChanged,
      hinttext}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: searchField(
              controller: controllerForSearcing,
              onChanged: onChanged,
              hintText: hinttext),
        ),
        const Expanded(
          flex: 0,
          child: SizedBox(),
        ),
        gapX(10),
        Expanded(
          flex: 0,
          child: InkWell(
            onTap: () {
              printer(searchcontroller!.searchTextController!.text);
              if (searchcontroller.searchTextController!.text.isNotEmpty) {
                searchcontroller.getSearchData(
                    searchTexts: searchcontroller.searchTextController!.text);

                StorageManager.saveData('searchhistory',
                    searchcontroller.searchTextController!.text);
                searchList = searchcontroller.searchDataLists.articles!;
                setState(() {});
              } else {
                snackBarProject(context: context, title: 'Search Box is Empty');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: PColors.basicColor,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  UdDesign.pt(8),
                ),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: PColors.containerColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
