import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/views/home/components/utilities/allpopularnewswebsite.dart';
import 'package:ud_design/ud_design.dart';

import '../../../utilities/constants/colors.dart';

class TopBarListView extends StatelessWidget {
  final HomeController homecontroller;
  final int pagenumber;
  const TopBarListView(
      {Key? key, required this.homecontroller, required this.pagenumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
              pagenumber;
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
                homecontroller
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
                        fontSize: UdDesign.fontSize(15), color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
