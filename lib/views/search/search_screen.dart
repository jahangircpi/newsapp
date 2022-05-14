import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/widgets/contianer_white.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerForSearcing = TextEditingController();
    ScrollController scrollController = ScrollController();
    return Scaffold(
      body: SafeArea(
        child: Consumer<SearchController>(
          builder: ((context, searchcontroller, child) {
            return Column(
              children: [
                gapY(PThemes.padding),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: UdDesign.pt(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: controllerForSearcing,
                          decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              fillColor: Colors.white,
                              filled: true,
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: PColors.backgrounColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: PColors.backgrounColor, width: 1.0),
                              ),
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search anything'),
                        ),
                      ),
                      const Expanded(
                        flex: 0,
                        child: SizedBox(),
                      ),
                      gapX(10),
                      Expanded(
                        flex: 0,
                        child: InkWell(
                          onTap: () async {
                            if (controllerForSearcing.text.isNotEmpty) {
                              await searchcontroller.getSearchData(
                                  searchTexts: controllerForSearcing.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: UdDesign.pt(50),
                                    ),
                                    child: const Text('Search box is empty'),
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: PColors.basicColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(
                                UdDesign.pt(8),
                              ),
                              child: const Text(
                                'Search',
                                style: TextStyle(
                                  color: PColors.containerColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                gapY(4),
                Expanded(
                  child: containerwhite(
                      dataStateEnum: searchcontroller.searchDataState,
                      listName: searchcontroller.searchDataLists.articles,
                      listController: scrollController),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Row searchBar({searchcontroller, textController}) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                fillColor: Colors.white,
                filled: true,
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: PColors.backgrounColor, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: PColors.backgrounColor, width: 1.0),
                ),
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search here'),
          ),
        ),
        const Expanded(
          flex: 0,
          child: SizedBox(),
        ),
        gapX(10),
        Expanded(
          flex: 0,
          child: InkWell(
            onTap: () {
              searchcontroller.getSearchData(searchTexts: textController.text);
            },
            child: const Text(
              'Search',
              style: TextStyle(
                color: PColors.containerColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
