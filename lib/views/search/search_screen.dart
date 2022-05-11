import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/enums.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/widgets/netimagecalling.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController controllerForSearcing = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ChangeNotifierProvider<SearchController>(
        create: (_) => SearchController(),
        child: Consumer<SearchController>(
            builder: ((context, searchcontroller, child) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: controllerForSearcing,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          fillColor: Colors.white,
                          filled: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: PColors.backgrounColor, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: PColors.backgrounColor, width: 1.0),
                          ),
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search here'),
                    ),
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
                        searchcontroller.getSearchData(
                            searchTexts: controllerForSearcing.text);
                      },
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
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: UdDesign.pt(8),
                  ),
                  child: searchcontroller.categoryDataState ==
                              DataState.loading ||
                          searchcontroller.categoryDataState ==
                              DataState.initial
                      ? const Center(child: Text('olala'))
                      : searchcontroller.categoryDataState == DataState.error
                          ? const Center(
                              child: Text(
                                "There is a Problem!",
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchcontroller
                                  .searchDataLists.articles!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var lists = searchcontroller
                                    .searchDataLists.articles![index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: UdDesign.pt(4)),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: PColors.containerColor,
                                        borderRadius: BorderRadius.circular(
                                          UdDesign.pt(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 0,
                                            child: SizedBox(
                                              width: UdDesign.pt(100),
                                              height: UdDesign.pt(100),
                                              child: networkImagescall(
                                                  src: lists.urlToImage ??
                                                      "https://firebasestorage.googleapis.com/v0/b/portfolio-8523e.appspot.com/o/loading.png?alt=media&token=894ae105-847f-48e5-af95-7467dafa74e2"),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 0,
                                            child: gapX(5),
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  gapY(5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        color: Colors.red,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                UdDesign.pt(8),
                                                            vertical:
                                                                UdDesign.pt(8),
                                                          ),
                                                          child: Text(
                                                            lists.source!
                                                                    .name ??
                                                                "Source",
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                      const Text("3:40 PM")
                                                    ],
                                                  ),
                                                  gapY(5),
                                                  Text(
                                                    lists.title ??
                                                        "got error to load",
                                                    style: TextStyle(
                                                        fontSize:
                                                            UdDesign.fontSize(
                                                                18),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                ),
              ),
            ],
          );
        })),
      )),
    );
  }

  Row searchBar({searchcontroller}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            controller: controllerForSearcing,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: PColors.backgrounColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: PColors.backgrounColor, width: 1.0),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search here'),
          ),
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
              searchcontroller.getSearchData(
                  searchTexts: controllerForSearcing.text);
            },
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
      ],
    );
  }
}
