import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/utilities/constants/urls.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/utilities/widgets/netimagecalling.dart';
import 'package:newsapp/utilities/widgets/top_sheet.dart';
import 'package:newsapp/views/home/components/allpopularnewswebsite.dart';
import 'package:newsapp/views/home/components/filtersection.dart';
import 'package:newsapp/views/home/components/start_drawer.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/services/sharedpreference_service.dart';
import '../../utilities/widgets/contianer_white.dart';
import 'components/apikeyslists.dart';
import 'components/settings_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _controller = ScrollController();
  late final ScrollController _controller2 = ScrollController();
  @override
  void initState() {
    super.initState();
    var newList = popularwebsiteLists
        .map((e) => e.title!)
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '')
        .trim();
    StorageManager.readData("apiKey").then((value) {
      if (value != null) {
        Urls.apiKey = value;
      }

      context.read<HomeController>().apikey = value;
    }).then(((value) {
      callBack(() {
        if (context.read<HomeController>().homeDataState != DataState.loaded) {
          context.read<HomeController>().getHomeData(newswebsite: newList);
        }
        if (context.read<SearchController>().searchDataState !=
            DataState.loaded) {
          context
              .read<SearchController>()
              .getSearchData(searchTexts: 'Flutter');
        }
      });
    }));

    paginationwithcontroller(newList);
  }

  int page = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const StartDrawer(),
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homecontroller, child) {
            return Column(
              children: [
                gapY(10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: UdDesign.pt(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilterSection(homecontroller: homecontroller),
                      SettingSection(homecontroller: homecontroller),
                    ],
                  ),
                ),
                topbarCategory(homecontroller),
                slidinglistview(size),
                Expanded(
                  child: containerwhite(
                    dataStateEnum: homecontroller.homeDataState,
                    listController: _controller2,
                    listName: homecontroller.articlesLists!,
                    onTap: () {
                      //b0be5f92f10d4436a83e56b900097622
                      // 572e6aeed52e407c8dcf7a6d03cd980d
                      printer(Urls.apiKey);
                      printer(page);
                      printer(homecontroller.articlesLists!.length);
                    },
                  ),
                ),
                homecontroller.homeDataState == DataState.isMoreDatAvailable
                    ? CircularProgressIndicator()
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

  InkWell settingsection(
      BuildContext context, Size size, HomeController homecontroller) {
    return InkWell(
      onTap: () {
        showTopModalSheet(
          context: context,
          child: Container(
            height: size.height * 0.2,
            color: PColors.backgrounColor,
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'API Keys',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DropdownButton(
                  dropdownColor: PColors.backgrounColor,
                  value: homecontroller.apikey,
                  items: apikeyslists2.map((e) {
                    return DropdownMenuItem<String>(
                      value: e.title!,
                      child: Text(
                        e.name!.toString().toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (v) {
                    homecontroller.updateapikey(
                      key: v,
                    );
                    Urls.apiKey = homecontroller.apikey!;
                    StorageManager.saveData("apiKey", homecontroller.apikey!);
                  },
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    pop(context: context);
                    var newList = popularwebsiteLists
                        .map((e) => e.title!)
                        .toList()
                        .toString()
                        .replaceAll('[', '')
                        .replaceAll(']', '')
                        .replaceAll(' ', '')
                        .trim();
                    homecontroller.getHomeData(newswebsite: newList);
                  },
                  child: Container(
                    color: PColors.basicColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UdDesign.pt(12),
                        vertical: UdDesign.pt(12),
                      ),
                      child: const Text(
                        "Update the key and load",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: const Icon(
        Icons.settings,
        color: Colors.white,
      ),
    );
  }

  Consumer<SearchController> slidinglistview(Size size) {
    return Consumer<SearchController>(
      builder: ((context, searchcontroller, child) {
        return searchcontroller.searchDataState == DataState.initial
            ? const SizedBox()
            : searchcontroller.searchDataState == DataState.loading
                ? const Text("Data is loading")
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
                                                textofnoimage: Colors.white),
                                          ),
                                        ),
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

  Widget topbarCategory(HomeController homecontroller) {
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
                      page = 1;
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
                            .getHomeData(
                                newswebsite: newList,
                                fromdate: DateTime(
                                        homecontroller.dateNow.year,
                                        homecontroller.dateNow.month - 1,
                                        homecontroller.dateNow.day)
                                    .toString()
                                    .split(' ')[0],
                                todate: homecontroller.dateNow)
                            .toString()
                            .split(' ')[0];
                      } else {
                        homecontroller
                            .getHomeData(
                                newswebsite: popularwebsiteLists[index].title!,
                                fromdate: DateTime(
                                        homecontroller.dateNow.year,
                                        homecontroller.dateNow.month - 1,
                                        homecontroller.dateNow.day)
                                    .toString()
                                    .split(' ')[0],
                                todate: homecontroller.dateNow)
                            .toString()
                            .split(' ')[0];
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

  paginationwithcontroller(String newList) {
    return _controller2.addListener(() {
      if (_controller2.position.pixels ==
          _controller2.position.maxScrollExtent) {
        printer("reached end");
        page++;
        if (page <= 5) {
          if (popularwebsiteLists[
                      context.read<HomeController>().popularItemIndex!]
                  .title ==
              'All') {
            context
                .read<HomeController>()
                .getMoreTask(
                    newswebsite: newList,
                    pagees: page,
                    fromdate: DateTime(
                            context.read<HomeController>().dateNow.year,
                            context.read<HomeController>().dateNow.month - 1,
                            context.read<HomeController>().dateNow.day)
                        .toString()
                        .split(' ')[0],
                    todate: context.read<HomeController>().dateNow)
                .toString()
                .split(' ')[0];
          } else {
            context
                .read<HomeController>()
                .getMoreTask(
                    pagees: page,
                    newswebsite: popularwebsiteLists[
                            context.read<HomeController>().popularItemIndex!]
                        .title!,
                    fromdate: DateTime(
                            context.read<HomeController>().dateNow.year,
                            context.read<HomeController>().dateNow.month - 1,
                            context.read<HomeController>().dateNow.day)
                        .toString()
                        .split(' ')[0],
                    todate: context.read<HomeController>().dateNow)
                .toString()
                .split(' ')[0];
          }
          // context
          //     .read<HomeController>()
          //     .getMoreTask(newswebsite: newList, pagees: page);
        }
      }
    });
  }
}
