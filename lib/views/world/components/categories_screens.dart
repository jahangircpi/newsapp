import 'package:flutter/material.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../../utilities/constants/colors.dart';
import '../../../utilities/widgets/contianer_white.dart';

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
                      worldcontroller: worldcontroller,
                      listName: worldcontroller.worldnewsLists),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget container({imageurl, title, description, height, detailsurl, source}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.network(
                  imageurl ??
                      "https://i.pinimg.com/originals/10/b2/f6/10b2f6d95195994fca386842dae53bb2.png",
                  width: double.infinity,
                  height: height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              title ?? "Title will be displayed here",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(description ?? "Description will be displayed here"),
          ],
        ),
      ),
    );
  }
}

class Categorylist {
  String? title;
  String? imageurl;
  Categorylist({this.title, this.imageurl});
}

List<Categorylist> catLists = [
  Categorylist(
      title: "business",
      imageurl:
          "https://img.freepik.com/free-photo/business-brainstorming-graph-chart-report-data-concept_53876-31213.jpg?size=626&ext=jpg"),
  Categorylist(
      title: "entertainment",
      imageurl:
          "https://images.unsplash.com/photo-1601407422822-a53f7f7a09c4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
  Categorylist(
      title: "general",
      imageurl:
          "https://images.unsplash.com/photo-1503497928123-ae945f95fd2f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
  Categorylist(
      title: "health",
      imageurl:
          "https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
  Categorylist(
      title: "science",
      imageurl:
          "https://images.unsplash.com/photo-1517976487492-5750f3195933?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"),
  Categorylist(
      title: "sports",
      imageurl:
          "https://images.unsplash.com/photo-1612811549877-c45e76353a7d?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80"),
  Categorylist(
      title: "technology",
      imageurl:
          "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80")
];
