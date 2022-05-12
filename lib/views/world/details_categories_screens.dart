import 'package:flutter/material.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/views/world/components/category_lists.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../utilities/constants/colors.dart';
import '../../utilities/widgets/contianer_white.dart';

class Detailsglobal extends StatefulWidget {
  final String? country;
  final String? fullcountryname;
  const Detailsglobal(
      {Key? key, required this.country, required this.fullcountryname})
      : super(key: key);

  @override
  State<Detailsglobal> createState() => _DetailsglobalState();
}

class _DetailsglobalState extends State<Detailsglobal> {
  @override
  void initState() {
    super.initState();
    callBack(() {
      context.read<WorldController>().getCategoryData(
          countryname: widget.country, categoryName: "business");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          widget.fullcountryname!,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Consumer<WorldController>(
          builder: ((context, worldcontroller, child) {
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
                          itemCount: catLists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: UdDesign.pt(4),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  worldcontroller.getCategoryIndex(
                                      givenIndex: index);
                                  worldcontroller.getCategoryData(
                                      categoryName: catLists[index].title,
                                      countryname: widget.country);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        worldcontroller.categoryIndex == index
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
                                        catLists[index].title!,
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
                      dataStateEnum: worldcontroller.worldDataState,
                      controller: worldcontroller,
                      listName: worldcontroller.worldnewsLists),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
