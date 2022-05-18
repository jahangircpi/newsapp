import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/constants/themes.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/world/components/screens/details_categories_screens.dart';
import 'package:newsapp/models/global_countries.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';
import '../../controllers/world_controller.dart';
import '../../utilities/functions/gap.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: globalKey,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: PThemes.padding,
            ),
            child: Column(
              children: [
                gapY(PThemes.padding),
                searchTop(context, size),
                gapY(10),
                Expanded(
                  child: gridviewbody(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget searchTop(BuildContext context, Size size) {
    return Expanded(
      flex: 0,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: searchField(
                controller: textController,
                hintText: 'Search Country',
                onChanged: (v) {
                  countriesnames = fullCountriesName.where((ee) {
                    return ee.name!.toString().toLowerCase().contains(v);
                  }).toList();
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }

  Widget gridviewbody(BuildContext context) {
    return GridView.builder(
      itemCount: countriesnames!.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: UdDesign.pt(7),
        childAspectRatio: 2.2,
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
}
