import 'package:flutter/material.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:ud_design/ud_design.dart';
import '../../../../../utilities/constants/colors.dart';
import '../../category_lists.dart';

class TopCategoryListView extends StatelessWidget {
  final String? country;
  final WorldController worldcontroller;
  const TopCategoryListView(
      {Key? key, required this.country, required this.worldcontroller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: UdDesign.pt(4),
        vertical: UdDesign.pt(6),
      ),
      child: SizedBox(
        height: UdDesign.pt(50),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: catLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: UdDesign.pt(4),
                vertical: UdDesign.pt(6),
              ),
              child: GestureDetector(
                onTap: () {
                  worldcontroller.getCategoryIndex(givenIndex: index);
                  worldcontroller.getCategoryData(
                      categoryName: catLists[index].title,
                      countryname: country);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: worldcontroller.categoryIndex == index
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
                        catLists[index].title!.toString().toUpperCase(),
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
    );
  }
}
