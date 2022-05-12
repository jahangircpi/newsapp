import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:provider/provider.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/widgets/contianer_white.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerForSearcing = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Consumer<SearchController>(
          builder: ((context, searchcontroller, child) {
            return Column(
              children: [
                gapY(PThemes.padding),
                Row(
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
                          printer(controllerForSearcing.text);
                          searchcontroller.getSearchData(
                              searchTexts: controllerForSearcing.text);
                          // if (controllerForSearcing.text.isNotEmpty) {
                          //   await searchcontroller.getSearchData(
                          //       searchTexts: controllerForSearcing.text);
                          //   printer(searchcontroller.searchDataState);
                          // } else {
                          //   printer('hello');
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Padding(
                          //         padding: EdgeInsets.symmetric(
                          //           horizontal: UdDesign.pt(100),
                          //         ),
                          //         child: const Text('Search box is empty'),
                          //       ),
                          //       behavior: SnackBarBehavior.floating,
                          //       backgroundColor: Colors.red,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(24),
                          //       ),
                          //     ),
                          //   );
                          // }
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
                ),
                Expanded(
                  child: containerwhite(
                      dataStateEnum: searchcontroller.searchDataState,
                      controller: searchcontroller,
                      listName: searchcontroller.searchDataLists),
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
