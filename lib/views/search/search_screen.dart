import 'package:flutter/material.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/services/sharedpreference_service.dart';
import 'package:newsapp/utilities/widgets/search_bar.dart';
import 'package:newsapp/utilities/widgets/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../utilities/constants/themes.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/functions/navigations.dart';
import '../../utilities/widgets/contianer_white.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
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
                  child: searchSection(
                      controllerForSearcing:
                          searchcontroller.searchTextController,
                      searchcontroller: searchcontroller,
                      context: context,
                      hinttext: 'Search Anything'),
                ),
                gapY(4),
                Expanded(
                  child: containerwhite(
                    dataStateEnum: searchcontroller.searchDataState,
                    listName: searchcontroller.searchDataLists.articles,
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget searchSection(
      {TextEditingController? controllerForSearcing,
      SearchController? searchcontroller,
      BuildContext? context,
      onChanged,
      hinttext}) {
    return Row(
      children: [
        Expanded(
            flex: 4,
            child: searchField(
                controller: controllerForSearcing,
                onChanged: onChanged,
                hintText: hinttext)),
        const Expanded(
          flex: 0,
          child: SizedBox(),
        ),
        gapX(10),
        Expanded(
          flex: 0,
          child: InkWell(
            onTap: () {
              if (searchcontroller!.searchTextController!.text.isNotEmpty) {
                searchcontroller.getSearchData(
                    searchTexts: searchcontroller.searchTextController!.text);
                StorageManager.saveData('searchhistory',
                    searchcontroller.searchTextController!.text);
              } else {
                snackBarProject(context: context, title: 'Search Box is Empty');
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
    );
  }
}
