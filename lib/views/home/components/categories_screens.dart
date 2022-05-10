import 'package:flutter/material.dart';
import 'package:newsapp/controllers/newscontroller.dart';
import 'package:newsapp/utilities/constants/enums.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:provider/provider.dart';

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
      context.read<NewsController>().getCategoryData(
          countryname: widget.country, categoryName: "business");
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
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
      body: SafeArea(child:
          Consumer<NewsController>(builder: ((context, newscontroller, child) {
        return Column(
          children: [
            Expanded(
              flex: 0,
              child: SizedBox(
                height: size.height * 0.2,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: catLists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PhysicalModel(
                        color: Colors.cyan,
                        elevation: 10,
                        child: InkWell(
                          onTap: () async {
                            await newscontroller.getCategoryData(
                                countryname: 'au',
                                categoryName: catLists[index].title);
                            // Get.dialog(Dialog(
                            //   child: Container(
                            //     height: 400,
                            //     child:
                            //         Center(child: CircularProgressIndicator()),
                            //   ),
                            // ));

                            // extrem
                            //     .fetchdata2(
                            //   country: country,
                            //   category: "${CatLists[index].title}",
                            // )
                            //     .then((value) {
                            //   print(value);
                            //   ctx.category.value = value;

                            //   Get.back();
                            //   Get.to(
                            //       categorypage(title: CatLists[index].title));
                            // });
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  catLists[index].imageurl!,
                                  fit: BoxFit.cover,
                                  height: size.height * 0.13,
                                  width: size.width * 0.35,
                                ),
                              ),
                              Center(
                                child: Text(
                                  catLists[index].title.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: newscontroller.categoriesLists.articles!.length,
                itemBuilder: (BuildContext context, int index) {
                  var lists = newscontroller.categoriesLists.articles![index];

                  return newscontroller.categoryDataState == DataState.loading
                      ? const Center(child: CircularProgressIndicator())
                      : container(
                          detailsurl: lists.url,
                          imageurl: lists.urlToImage,
                          title: lists.title,
                          description: lists.description,
                          height: size.height * 0.24,
                          source: lists.source!.name!.toString());
                },
              ),
            )
          ],
        );
      }))),
    );
  }
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
