import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/inappviewscreen.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:provider/provider.dart';
import 'package:ud_design/ud_design.dart';

import '../../../controllers/search_controller.dart';
import '../../../utilities/constants/enums.dart';
import '../../../utilities/widgets/netimagecalling.dart';

class SliddingNewsSection extends StatelessWidget {
  final Size size;
  const SliddingNewsSection({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final CarouselController carouselController = CarouselController();

    return Consumer<SearchController>(
      builder: ((context, searchcontroller, child) {
        return searchcontroller.searchDataState == DataState.initial
            ? const SizedBox()
            : searchcontroller.searchDataState == DataState.loading
                ? const Text("Data is loading")
                : searchcontroller.searchDataState == DataState.loaded
                    ? searchcontroller.isTopBarShown == false
                        ? const SizedBox()
                        : Stack(
                            children: [
                              SizedBox(
                                width: size.width,
                                child: CarouselSlider(
                                  carouselController: carouselController,
                                  options: CarouselOptions(
                                    height: UdDesign.pt(160),
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.75,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 4),
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    onPageChanged: (value, _) {
                                      searchcontroller.getHomeIndex(
                                          givenIndex: value);
                                    },
                                    scrollDirection: Axis.horizontal,
                                  ),
                                  items: searchcontroller
                                      .searchDataLists.articles!
                                      .map((e) {
                                    return InkWell(
                                      onTap: () {
                                        push(
                                            screen: InAppWebViewScreen(
                                                website: e.url!),
                                            context: context);
                                      },
                                      child: Stack(
                                        children: [
                                          SizedBox(
                                            width: size.width,
                                            child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: UdDesign.pt(4),
                                                ),
                                                child: networkImagescall(
                                                    src: e.urlToImage ?? "",
                                                    textofnoimage:
                                                        Colors.white)),
                                          ),
                                          Positioned(
                                            bottom: UdDesign.pt(20),
                                            left: 0,
                                            child: SingleChildScrollView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              child: SizedBox(
                                                height: UdDesign.pt(180),
                                                width: size.width,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal:
                                                          UdDesign.pt(12),
                                                    ),
                                                    child: Text(
                                                      e.title ?? "",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            UdDesign.fontSize(
                                                                20),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: size.width * 0.25,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                      searchcontroller.searchDataLists.articles!
                                          .length, (index) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            searchcontroller.homeImageIndex ==
                                                    index
                                                ? const Color(0xFFFFFFFF)
                                                : Colors.white.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(
                                            searchcontroller.homeImageIndex ==
                                                    index
                                                ? UdDesign.pt(2)
                                                : 0),
                                      ),
                                      height: UdDesign.pt(8),
                                      width: searchcontroller.homeImageIndex ==
                                              index
                                          ? UdDesign.pt(10)
                                          : UdDesign.pt(2),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          )
                    : const Center(
                        child: Text("Data has some problems to show"),
                      );
      }),
    );
  }
}
