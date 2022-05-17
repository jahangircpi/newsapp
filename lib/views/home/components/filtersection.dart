import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/utilities/widgets/top_sheet.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/functions/navigations.dart';
import '../../../utilities/functions/print.dart';
import 'utilities/allpopularnewswebsite.dart';

class FilterSection extends StatelessWidget {
  final HomeController homecontroller;
  const FilterSection({Key? key, required this.homecontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Icon(
        Icons.filter_alt,
        color: Colors.white,
      ),
      onTap: () {
        showTopModalSheet(
          context: context,
          child: Container(
            color: Colors.white,
            // height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "NewsPaper",
                ),
                gapY(10),
                Container(
                  color: PColors.backgrounColor,
                  child: DropdownButton(
                    dropdownColor: PColors.backgrounColor,
                    alignment: Alignment.center,
                    value: homecontroller.selectNewsPaper,
                    items: popularwebsiteLists.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.title!,
                        child: Text(
                          e.webSite!.toString().toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    }).toList(),
                    onChanged: (v) {
                      homecontroller.updateNewsPaper(
                        newspaper: v,
                      );
                      printer(v);
                    },
                  ),
                ),
                gapY(10),
                InkWell(
                  onTap: () async {},
                  child: const Text(
                    'Pick the days',
                  ),
                ),
                gapY(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final now = DateTime.now();
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(now.year, now.month - 1, now.day),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) => homecontroller.updateDate(
                              fromdate: value, fromorto: "fromfunction"),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: PColors.backgrounColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: UdDesign.pt(20),
                            vertical: UdDesign.pt(10),
                          ),
                          child: const Text(
                            'From',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        final now = DateTime.now();
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(now.year, now.month - 1, now.day),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) => homecontroller.updateDate(
                              fromdate: value, fromorto: "forto"),
                        );
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: PColors.backgrounColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: UdDesign.pt(20),
                            vertical: UdDesign.pt(10),
                          ),
                          child: const Text(
                            'To',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UdDesign.pt(20),
                        vertical: UdDesign.pt(10),
                      ),
                      child: Text(
                        homecontroller.fromDate.toString().split(' ')[0],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UdDesign.pt(20),
                        vertical: UdDesign.pt(10),
                      ),
                      child: Text(
                        homecontroller.toDate.toString().split(' ')[0],
                      ),
                    ),
                  ],
                ),
                gapY(30),
                GestureDetector(
                  onTap: () {
                    pop(context: context);

                    if (homecontroller.selectNewsPaper == 'All') {
                      var newList = popularwebsiteLists
                          .map((e) => e.title!)
                          .toList()
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', '')
                          .replaceAll(' ', '')
                          .trim();
                      context.read<HomeController>().getHomeData(
                          newswebsite: newList,
                          fromdate:
                              homecontroller.fromDate.toString().split(' ')[0],
                          todate:
                              homecontroller.toDate.toString().split(' ')[0]);
                    } else {
                      homecontroller.getHomeData(
                          newswebsite: homecontroller.selectNewsPaper,
                          fromdate:
                              homecontroller.fromDate.toString().split(' ')[0],
                          todate:
                              homecontroller.toDate.toString().split(' ')[0]);
                    }
                  },
                  child: Container(
                    color: PColors.basicColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UdDesign.pt(80),
                        vertical: UdDesign.pt(10),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                gapY(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
