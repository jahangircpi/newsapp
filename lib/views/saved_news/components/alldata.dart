import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newsapp/controllers/favorite_controller.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/webview_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ud_design/ud_design.dart';
import '../../../utilities/functions/gap.dart';
import '../../../utilities/functions/print.dart';
import '../../../utilities/widgets/netimagecalling.dart';

class AllSavedDataLists extends StatelessWidget {
  final List<Article>? listName;
  final FavoriteController? favoritecontroller;
  const AllSavedDataLists(
      {Key? key, required this.listName, required this.favoritecontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return listName!.isEmpty
        ? const Center(
            child: Text(
            'Saved List is empty',
            style: TextStyle(color: Colors.white),
          ))
        : ListView.builder(
            itemCount: listName!.length,
            itemBuilder: (BuildContext context, int index) {
              var lists = listName![index];
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: UdDesign.pt(4),
                  vertical: UdDesign.pt(4),
                ),
                child: InkWell(
                  onTap: () {
                    push(
                        screen: InAppWebViewPage(website: lists.url!),
                        context: context);
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: Colors.primaries[Random()
                                      .nextInt(Colors.primaries.length)],
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: UdDesign.pt(3),
                                      vertical: UdDesign.pt(3),
                                    ),
                                    child: Text(
                                      lists.source!.name!,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                gapY(4),
                                Text(
                                  lists.title!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: UdDesign.fontSize(16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 0,
                            child: SizedBox(
                              width: size.width * 0.3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child:
                                    networkImagescall(src: lists.urlToImage!),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: UdDesign.pt(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Share.share(lists.url!);
                                printer(lists.url!);
                              },
                              child: Icon(
                                Icons.share,
                                color: Colors.white,
                                size: UdDesign.pt(24),
                              ),
                            ),
                            gapX(10),
                            InkWell(
                              onTap: () {
                                favoritecontroller!
                                    .addingtoLists(newsItem: lists);
                              },
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: UdDesign.pt(24),
                                ),
                              ),
                            ),
                            gapX(10),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
