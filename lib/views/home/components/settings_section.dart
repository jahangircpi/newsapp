import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/views/home/components/apikeyslists.dart';
import 'package:newsapp/views/saved_news/saved_news.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../../controllers/home_controller.dart';
import '../../../utilities/constants/colors.dart';
import '../../../utilities/constants/urls.dart';
import '../../../utilities/functions/navigations.dart';
import '../../../utilities/services/sharedpreference_service.dart';
import '../../../utilities/widgets/top_sheet.dart';
import 'allpopularnewswebsite.dart';

class SettingSection extends StatelessWidget {
  final HomeController? homecontroller;

  const SettingSection({Key? key, this.homecontroller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTopModalSheet(
          context: context,
          child: Container(
            color: PColors.backgrounColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return DropdownButton(
                      dropdownColor: PColors.backgrounColor,
                      value: homecontroller!.apikey,
                      items: apikeyslists2.map((e) {
                        return DropdownMenuItem<String>(
                          // onTap: () {
                          //   homecontroller.updateNewsPaper(
                          //     newspaper: e.title!,
                          //   );
                          // },
                          value: e.title!,
                          child: Text(
                            e.name!.toString().toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (v) {
                        setState(
                          () {
                            homecontroller!.updateapikey(
                              key: v,
                            );
                            Urls.apiKey = homecontroller!.apikey!;
                            StorageManager.saveData(
                                "apiKey", homecontroller!.apikey!);
                          },
                        );
                      },
                    );
                  },
                ),
                Row(
                  children: [
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
                        homecontroller!.getHomeData(newswebsite: newList);
                        context
                            .read<SearchController>()
                            .getSearchData(searchTexts: 'Flutter');
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
                    ),
                    InkWell(
                        onTap: () {
                          push(
                              screen: const SavedNewsScreen(),
                              context: context);
                        },
                        child: const Text("Saved News Screen"))
                  ],
                ),
                gapY(20)
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
}
