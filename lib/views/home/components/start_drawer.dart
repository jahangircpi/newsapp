import 'package:flutter/material.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/models/global_countries.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/views/world/components/category_lists.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import 'allpopularnewswebsite.dart';

class StartDrawer extends StatelessWidget {
  const StartDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value = 'All';
    return SafeArea(child: Consumer<HomeController>(
      builder: ((context, homecontroller, child) {
        return Drawer(
          child: Column(
            children: [
              const Text("Select Your NewsPaper List"),
              DropdownButton(
                value: homecontroller.selectNewsPaper,
                items: popularwebsiteLists.map((e) {
                  return DropdownMenuItem<String>(
                    // onTap: () {
                    //   homecontroller.updateNewsPaper(
                    //     newspaper: e.title!,
                    //   );
                    // },
                    value: e.title!,
                    child: Text(
                      e.webSite!.toString().toUpperCase(),
                    ),
                  );
                }).toList(),
                onChanged: (v) {
                  homecontroller.updateNewsPaper(
                    newspaper: v,
                  );
                },
              ),
              InkWell(
                onTap: () async {},
                child: const Text('Pick the days'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final now = DateTime.now();
                      await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900, now.month, now.day),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) => homecontroller.updateDate(
                            fromdate: value, fromorto: "fromfunction"),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: PColors.backgrounColor,
                        borderRadius: BorderRadius.circular(15),
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
                        firstDate: DateTime(1900, now.month, now.day),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) => homecontroller.updateDate(
                            fromdate: value, fromorto: "forto"),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: PColors.backgrounColor,
                        borderRadius: BorderRadius.circular(15),
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
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(20),
                      vertical: UdDesign.pt(10),
                    ),
                    child: Text(
                      homecontroller.toDate.toString().split(' ')[0],
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const Spacer(),
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
                        todate: homecontroller.toDate.toString().split(' ')[0]);
                  } else {
                    printer('it is here ');
                    homecontroller.getHomeData(
                        newswebsite: homecontroller.selectNewsPaper,
                        fromdate:
                            homecontroller.fromDate.toString().split(' ')[0],
                        todate: homecontroller.toDate.toString().split(' ')[0]);
                  }
                },
                child: Container(
                  color: PColors.basicColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: UdDesign.pt(20),
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
        );
      }),
    ));
  }
}
