import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../functions/gap.dart';
import 'netimagecalling.dart';

containerwhite({required dataStateEnum, controller, listName}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: UdDesign.pt(8),
    ),
    child: dataStateEnum == DataState.initial
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: PColors.containerColor,
              color: PColors.sliverColor,
            ),
          )
        : dataStateEnum == DataState.loading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: PColors.containerColor,
                  color: PColors.sliverColor,
                ),
              )
            : dataStateEnum == DataState.error
                ? const Center(
                    child: Text(
                      "There is a Problem!",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: listName.articles!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var lists = listName.articles![index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: UdDesign.pt(4)),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: PColors.containerColor,
                              borderRadius: BorderRadius.circular(
                                UdDesign.pt(10),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: SizedBox(
                                    width: UdDesign.pt(100),
                                    height: UdDesign.pt(100),
                                    child: networkImagescall(
                                        src: lists.urlToImage ??
                                            "https://firebasestorage.googleapis.com/v0/b/portfolio-8523e.appspot.com/o/loading.png?alt=media&token=894ae105-847f-48e5-af95-7467dafa74e2"),
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: gapX(5),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        gapY(5),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                color: Colors.red,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: UdDesign.pt(8),
                                                    vertical: UdDesign.pt(8),
                                                  ),
                                                  child: Text(
                                                    lists.source!.name ??
                                                        "Source",
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                              gapX(10),
                                              Text(
                                                  "${lists.publishedAt.year.toString()}-${lists.publishedAt.month.toString().padLeft(2, '0')}-${lists.publishedAt.day.toString().padLeft(2, '0')} ${lists.publishedAt.hour.toString().padLeft(2, '0')}-${lists.publishedAt.minute.toString().padLeft(2, '0')}")
                                            ],
                                          ),
                                        ),
                                        gapY(5),
                                        Text(
                                          lists.title ?? "got error to load",
                                          style: TextStyle(
                                              fontSize: UdDesign.fontSize(18),
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
  );
}
