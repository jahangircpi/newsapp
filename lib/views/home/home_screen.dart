import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/callback.dart';
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
      context.read<HomeController>().getHomeData(newswebsite: newList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<HomeController>(
          builder: (context, homecontroller, child) {
            return Column(
              children: [
                SizedBox(
                  height: UdDesign.pt(100),
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
                  child: containerwhite(
                      worldcontroller: homecontroller,
                      listName: homecontroller.homedataLists),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
