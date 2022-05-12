import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/utilities/widgets/netimagecalling.dart';
import 'package:newsapp/views/home/components/allpopularnewswebsite.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../utilities/widgets/contianer_white.dart';

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
      if (context.read<HomeController>().homeDataState != DataState.loaded) {
        context.read<HomeController>().getHomeData(newswebsite: newList);
      }
      if (context.read<SearchController>().searchDataState !=
          DataState.loaded) {
        context.read<SearchController>().getSearchData(searchTexts: 'Flutter');
      }
    });
  }

  late final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homecontroller, child) {
            return Column(
              children: [
                topbarCategory(homecontroller),
                slidinglistview(size),
                Expanded(
                  child: containerwhite(
                      controller: homecontroller,
                      dataStateEnum: homecontroller.homeDataState,
                      listName: homecontroller.homedataLists),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Consumer<SearchController> slidinglistview(Size size) {
    return Consumer<SearchController>(
      builder: ((context, searchcontroller, child) {
        return searchcontroller.searchDataState == DataState.initial
            ? const SizedBox()
            : searchcontroller.searchDataState == DataState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : searchcontroller.searchDataState == DataState.loaded
                    ? Stack(
                        children: [
                          SizedBox(
                            height: UdDesign.pt(160),
                            width: size.width,
                            child: NotificationListener(
                              onNotification: ((notification) {
                                setState(() {
                                  searchcontroller.homeImageIndex =
                                      (_controller.offset / size.width)
                                              .round() +
                                          0;
                                });
                                return true;
                              }),
                              child: ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: searchcontroller
                                    .searchDataLists.articles!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Stack(
                                    children: [
                                      SizedBox(
                                        width: size.width,
                                        child: InkWell(
                                            onTap: () {
                                              printer(searchcontroller
                                                  .homeImageIndex);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: UdDesign.pt(4),
                                              ),
                                              child: networkImagescall(
                                                src: searchcontroller
                                                    .searchDataLists
                                                    .articles![index]
                                                    .urlToImage!,
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                        bottom: UdDesign.pt(15),
                                        left: 0,
                                        child: SingleChildScrollView(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          child: SizedBox(
                                            height: UdDesign.pt(180),
                                            width: size.width,
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: UdDesign.pt(8),
                                                ),
                                                child: InkWell(
                                                  onTap: () {
                                                    printer(searchcontroller
                                                        .homeImageIndex);
                                                  },
                                                  child: Text(
                                                    searchcontroller
                                                        .searchDataLists
                                                        .articles![index]
                                                        .title!,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize:
                                                          UdDesign.fontSize(20),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: UdDesign.pt(4),
                            left: size.width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  searchcontroller.searchDataLists.articles!
                                      .length, (index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color:
                                        searchcontroller.homeImageIndex == index
                                            ? const Color(0xFFFFFFFF)
                                            : Colors.white.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(
                                        searchcontroller.homeImageIndex == index
                                            ? UdDesign.pt(2)
                                            : 0),
                                  ),
                                  height: UdDesign.pt(8),
                                  width:
                                      searchcontroller.homeImageIndex == index
                                          ? UdDesign.pt(10)
                                          : UdDesign.pt(2),
                                );
                              }),
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text("Data has some problems to show"),
                      );
      }),
    );
  }

  SizedBox topbarCategory(HomeController homecontroller) {
    return SizedBox(
      height: UdDesign.pt(80),
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
                      homecontroller.getPopularItemIndex(indexGiven: index);
                      if (popularwebsiteLists[index].title == 'All') {
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
                            newswebsite: popularwebsiteLists[index].title!);
                      }
                    },
                    child: Container(
                      // color: PColors.basicColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: homecontroller.popularItemIndex == index
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
    );
  }
}
