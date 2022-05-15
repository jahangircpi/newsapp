import 'package:flutter/material.dart';
import 'package:newsapp/models/home_page_news_model.dart';
import 'package:ud_design/ud_design.dart';

import '../../../utilities/functions/gap.dart';
import '../../../utilities/widgets/netimagecalling.dart';

class AllSavedDataLists extends StatelessWidget {
  final List<Article>? listName;
  const AllSavedDataLists({Key? key, required this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: listName!.length,
      itemBuilder: (BuildContext context, int index) {
        var lists = listName![index];
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: UdDesign.pt(4),
            vertical: UdDesign.pt(4),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.red,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: UdDesign.pt(3),
                              vertical: UdDesign.pt(3),
                            ),
                            child: Text(
                              lists.source!.name!,
                              style: const TextStyle(color: Colors.white),
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
                        child: networkImagescall(src: lists.urlToImage!),
                      ),
                    ),
                  )
                ],
              ),
              gapY(10),
              const Divider(
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }
}
