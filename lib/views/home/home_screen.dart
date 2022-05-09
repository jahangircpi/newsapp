import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/views/home/components/categories_screens.dart';
import 'package:newsapp/views/home/components/global_countries.dart';

import '../../utilities/constants/urls.dart';
import '../../utilities/services/dio_services.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.cyan.withOpacity(0.9),
        appBar: AppBar(
          centerTitle: true,
          title: Text("News"),
          elevation: 10,
          backgroundColor: Colors.cyan.withOpacity(0.60),
        ),
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0), child: search()),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: fullCountriesName.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailsglobal(
                                    country:
                                        fullCountriesName[index].shortname!,
                                    fullcountryname:
                                        fullCountriesName[index].name!,
                                  ),
                                ),
                              );

                              // apicalledglobal
                              //     .fetchdata3(
                              //   ct.coname[index].shortname,
                              // )
                              //     .then((value) {
                              //   ct.countries.value = value;
                              //   Get.back();
                              //   Get.to(detailsglobal(
                              //     country: countriesname[index].name,
                              //     fullcountryname:
                              //         FullCountriesName[index].name,
                              //   ));
                              // });
                            },
                            child: PhysicalModel(
                              color: Colors.cyan.withOpacity(0.9),
                              shadowColor: Colors.white.withOpacity(0.40),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(80)),
                              elevation: 30,
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(80)),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(28.0),
                                    child: Text(
                                      fullCountriesName[index].name!,
                                      style: const TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
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
