import 'package:flutter/material.dart';
import 'package:newsapp/utilities/constants/assets.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/gap.dart';
import 'package:newsapp/utilities/services/dio_services.dart';
import 'package:newsapp/views/saved_news/saved_news.dart';
import 'package:newsapp/views/search/search_screen.dart';
import 'package:ud_design/ud_design.dart';
import 'home/home_screen.dart';
import 'world/world_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 1;

  getBody(current) {
    switch (current) {
      case 0:
        {
          return const WorldScreen();
        }

      case 1:
        {
          return const HomeScreen();
        }

      case 2:
        {
          return const SearchScreen();
        }
      case 3:
        {
          return const SavedNewsScreen();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    DioSingleton.instance.create();
    return Scaffold(
      body: getBody(_currentIndex),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: iconwithdesignmethod(
                  icon: Passets.worldIcon,
                  titleText: "World",
                  currentIndex: 0,
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: iconwithdesignmethod(
                    icon: Passets.homeIcon, titleText: "Home", currentIndex: 1),
                label: ''),
            BottomNavigationBarItem(
                icon: iconwithdesignmethod(
                    icon: Passets.searchIcon,
                    titleText: "Search",
                    currentIndex: 2),
                label: ''),
            BottomNavigationBarItem(
                icon: iconwithdesignmethod(
                    icon: Passets.saveIcon,
                    titleText: "Saved",
                    currentIndex: 3),
                label: ''),
          ],
        ),
      ),
    );
  }

  Widget iconwithdesignmethod({icon, titleText, currentIndex}) {
    return _currentIndex == currentIndex
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 2,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: PColors.backgrounColor,
                borderRadius: BorderRadius.circular(38),
              ),
              child: Column(
                children: [
                  gapY(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        icon,
                        color: _currentIndex == currentIndex
                            ? Colors.cyan
                            : Colors.black,
                        height: UdDesign.pt(25),
                      ),
                      gapX(5),
                      Text(
                        titleText ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: UdDesign.fontSize(14),
                        ),
                      )
                    ],
                  ),
                  gapY(5),
                ],
              ),
            ),
          )
        : Image.asset(
            icon,
            color: _currentIndex == currentIndex ? Colors.white : Colors.black,
            height: UdDesign.pt(22),
            fit: BoxFit.cover,
          );
  }
}
