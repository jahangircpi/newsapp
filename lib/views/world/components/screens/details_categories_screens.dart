import 'package:flutter/material.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:newsapp/utilities/functions/callback.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/functions/print.dart';
import 'package:newsapp/utilities/widgets/loading/three_bounch.dart';
import 'package:newsapp/views/world/components/category_lists.dart';
import 'package:newsapp/views/world/components/screens/components/topcategorylistview.dart';
import 'package:provider/provider.dart';
import '../../../../utilities/constants/enums.dart';
import '../../../../utilities/widgets/contianer_white.dart';
import 'components/topappbar.dart';

class Detailsglobal extends StatefulWidget {
  final String? country;
  final String? fullcountryname;
  const Detailsglobal(
      {Key? key, required this.country, required this.fullcountryname})
      : super(key: key);

  @override
  State<Detailsglobal> createState() => _DetailsglobalState();
}

class _DetailsglobalState extends State<Detailsglobal> {
  late ScrollController scrollercontroller = ScrollController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    callBack(() async {
      await datacallingInitstate();
    });
    paginations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<WorldController>(
          builder: ((context, worldcontroller, child) {
            return Column(
              children: [
                gapY(10),
                TopAppBar(fullcountryname: widget.fullcountryname!),
                TopCategoryListView(
                    country: widget.country, worldcontroller: worldcontroller),
                Expanded(
                  child: containerwhite(
                      dataStateEnum: worldcontroller.worldDataState,
                      listName: worldcontroller.worldnewsLists,
                      listController: scrollercontroller),
                ),
                worldcontroller.worldDataState == DataState.isMoreDatAvailable
                    ? const Loader(
                        color: Colors.white,
                      )
                    : const SizedBox(),
              ],
            );
          }),
        ),
      ),
    );
  }

// All Functionalities of InitState Start here//!
  Future<void> datacallingInitstate() async {
    await context
        .read<WorldController>()
        .getCategoryData(countryname: widget.country, categoryName: "business");
  }

  void paginations() {
    scrollercontroller.addListener(() {
      if (scrollercontroller.position.pixels ==
          scrollercontroller.position.maxScrollExtent) {
        printer("reached end");
        page++;
        if (page <= 5) {
          context.read<WorldController>().getmoreTask(
              countryname: widget.country,
              categoryName:
                  catLists[context.read<WorldController>().categoryIndex!]
                      .title,
              pages: page);
        }
      }
    });
  }
// All Functionalities of InitState Start here //!
}
