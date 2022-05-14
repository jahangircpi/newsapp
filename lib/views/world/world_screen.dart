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
import '../../controllers/world_controller.dart';
import '../../utilities/functions/gap.dart';

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
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: textController,
                          onChanged: (v) {
                            printer(v);
                            countriesnames = fullCountriesName.where((ee) {
                              return ee.name!
                                  .toString()
                                  .toLowerCase()
                                  .contains(v);
                            }).toList();
                            setState(() {});
                          },
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
                              hintText: 'Search country'),
                        ),
                      ),
                    ],
                  ),
                ),
                gapY(10),
                Expanded(
                  child: GridView.builder(
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
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  search() {
    return TextField(
      // controller: textEditingController,
      decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.only(left: 100),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18.0)),
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
              borderSide: BorderSide(color: Colors.red),
              gapPadding: 100),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: "Search country",
          hintStyle: TextStyle(color: Colors.white, fontSize: 25)),
      onChanged: (v) {
        // ct.coname.value = ct.searchlist
        //     .where((e) => e.name.toLowerCase().contains(v.toLowerCase()))
        //     .toList();
      },
    );
  }
}
