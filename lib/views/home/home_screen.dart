import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/utilities/constants/urls.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/home/components/utilities/allpopularnewswebsite.dart';
import 'package:newsapp/views/home/components/filtersection.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/favorite_controller.dart';
import '../../models/home_page_news_model.dart';
import '../../utilities/services/sharedpreference_service.dart';
import '../../utilities/widgets/contianer_white.dart';
import 'components/settings_section.dart';
import 'components/slidingnews.dart';
import 'components/topbarlistview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _controller2 = ScrollController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    String newList = sortingoutlist();
    StorageManager.readData("apiKey").then((value) {
      apikeyInitSection(value);
    }).then(
      ((value) async {
        callBack(() async {
          homedataInitSection(newList);
          await searchInitSection();
          await savetofavoriteSection();
        });
      }),
    );
    paginationwithcontroller(newList);
    scrollingtohidsliddingSection();
  }

  @override
  void dispose() {
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: globalKey,
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homecontroller, child) {
            return Column(
              children: [
                gapY(10),
                filterSection(homecontroller),
                topbarCategory(homecontroller),
                SliddingNewsSection(size: size),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(4),
                    ),
                    child: containerwhite(
                      dataStateEnum: homecontroller.homeDataState,
                      listController: _controller2,
                      listName: homecontroller.articlesLists!,
                    ),
                  ),
                ),
                homecontroller.homeDataState == DataState.isMoreDatAvailable
                    ? const CircularProgressIndicator()
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }

//All Widgets Method Begin Here// !
  Widget filterSection(HomeController homecontroller) {
    return Padding(
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
            child: TopBarListView(
              homecontroller: homecontroller,
              pagenumber: page,
            ),
          ),
        ],
      ),
    );
  }

//All Widgets Method End Here//!

  /// All Functionalities of InitState Start //!
  String sortingoutlist() {
    var newList = popularwebsiteLists
        .map((e) => e.title!)
        .toList()
        .toString()
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '')
        .trim();
    return newList;
  }

  void apikeyInitSection(value) {
    if (value != null) {
      Urls.apiKey = value;
    }

    context.read<HomeController>().apikey = value;
  }

  void homedataInitSection(String newList) {
    if (context.read<HomeController>().homeDataState != DataState.loaded) {
      context.read<HomeController>().getHomeData(newswebsite: newList);
    }
  }

  Future<void> searchInitSection() async {
    await StorageManager.readData('searchhistory').then((value) {
      if (value != null) {
        context.read<SearchController>().searchTextController!.text = value;
        if (context.read<SearchController>().searchDataState !=
            DataState.loaded) {
          context.read<SearchController>().getSearchData(searchTexts: value);
        }
      } else {
        context.read<SearchController>().getSearchData(searchTexts: 'Flutter');
      }
    });
  }

  Future<void> savetofavoriteSection() async {
    await StorageManager.readData('savedlists').then((value) {
      context.read<FavoriteController>().saveArticle = Article.decode(value);
    });
  }

  void paginationwithcontroller(String newList) {
    return _controller2.addListener(() {
      if (_controller2.position.pixels ==
          _controller2.position.maxScrollExtent) {
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

  void scrollingtohidsliddingSection() {
    _controller2.addListener(() {
      double maxScroll = _controller2.position.minScrollExtent;
      double currentScroll = _controller2.position.pixels;
      double delta = UdDesign.pt(100);
      if (maxScroll + currentScroll <= delta) {
        context.read<SearchController>().getTopBarShown(value: true);
      } else {
        context.read<SearchController>().getTopBarShown(value: false);
      }
    });
  }
// All Functionalities of InitState End//!
}
