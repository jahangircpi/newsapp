import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/constants/themes.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/views/world/details_categories_screens.dart';
import 'package:newsapp/models/global_countries.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/favorite_controller.dart';
import '../../controllers/world_controller.dart';
import '../../models/home_page_news_model.dart';
import '../../utilities/functions/gap.dart';
import '../../utilities/services/sharedpreference_service.dart';
import '../../utilities/widgets/search_bar.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({Key? key}) : super(key: key);

  @override
  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  TextEditingController textController = TextEditingController();
  Dio dio = Dio();
  List<Globalfull>? countriesnames;
  @override
  void initState() {
    super.initState();
    countriesnames = fullCountriesName;
    callBack(() async {
      await StorageManager.readData('savedlists').then((value) {
        context.read<FavoriteController>().saveArticle = Article.decode(value);
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PThemes.padding,
            ),
            child: Column(
              children: [
                gapY(PThemes.padding),
                Expanded(
                  flex: 0,
                  child: searchSection(),
                ),
                gapY(10),
                Expanded(
                  child: countriesGridList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  countriesGridList() {
    return GridView.builder(
      itemCount: countriesnames!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: UdDesign.pt(7),
        childAspectRatio: 2,
        crossAxisSpacing: UdDesign.pt(7),
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () async {
            context.read<WorldController>().categoryIndex = 0;
            push(
              context: context,
              screen: Detailsglobal(
                country: countriesnames![index].shortname!,
                fullcountryname: countriesnames![index].name!,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PColors.containerColor),
            child: Center(
              child: Text(
                countriesnames![index].name!,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Row searchSection() {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: searchField(
              controller: textController,
              hintText: 'Search Country',
              onChanged: (v) {
                printer(v);
                countriesnames = fullCountriesName.where((ee) {
                  return ee.name!.toString().toLowerCase().contains(v);
                }).toList();
                setState(() {});
              }),
        ),
      ],
    );
  }
}
