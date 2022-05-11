import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/widgets/netimagecalling.dart';
import 'package:newsapp/views/home/components/allpopularnewswebsite.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    callBack(() {
      var newList = popularwebsiteLists
          .map((e) => e.title!)
          .toList()
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .trim();
      context.read<HomeController>().getHomeData(newswebsite: newList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.withOpacity(0.2),
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homecontroller, child) {
            return Column(
              children: [
                Container(
                  height: UdDesign.pt(100),
                  color: PColors.backgrounColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: UdDesign.pt(50),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: popularwebsiteLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: UdDesign.pt(4),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  homecontroller.getPopularItemIndex(
                                      indexGiven: index);
                                  if (popularwebsiteLists[index].title ==
                                      'All') {
                                    var newList = popularwebsiteLists
                                        .map((e) => e.title!)
                                        .toList()
                                        .toString()
                                        .replaceAll('[', '')
                                        .replaceAll(']', '')
                                        .replaceAll(' ', '')
                                        .trim();
                                    context
                                        .read<HomeController>()
                                        .getHomeData(newswebsite: newList);
                                  } else {
                                    homecontroller.getHomeData(
                                        newswebsite:
                                            popularwebsiteLists[index].title!);
                                  }
                                },
                                child: Container(
                                  // color: PColors.basicColor,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        homecontroller.popularItemIndex == index
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
                                        popularwebsiteLists[index].webSite!,
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
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(8),
                    ),
                    child: homecontroller.categoryDataState ==
                                DataState.loading ||
                            homecontroller.categoryDataState ==
                                DataState.initial
                        ? const Center(
                            child: CircularProgressIndicator(
                              backgroundColor: PColors.containerColor,
                              color: PColors.sliverColor,
                            ),
                          )
                        : homecontroller.categoryDataState == DataState.error
                            ? const Center(
                                child: Text(
                                  "There is a Problem!",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: homecontroller
                                    .homedataLists.articles!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var lists = homecontroller
                                      .homedataLists.articles![index];
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
                                                                  UdDesign.pt(
                                                                      8),
                                                              vertical:
                                                                  UdDesign.pt(
                                                                      8),
                                                            ),
                                                            child: Text(
                                                              lists.source!
                                                                      .name ??
                                                                  "Source",
                                                              style: const TextStyle(
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
          },
        ),
      ),
    );
  }
}
