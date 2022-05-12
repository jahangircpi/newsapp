import 'package:flutter/material.dart';
import 'package:newsapp/utilities/constants/assets.dart';
import 'package:newsapp/utilities/constants/colors.dart';
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
  int _currentIndex = 0;

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
    }
  }

  @override
  Widget build(BuildContext context) {
    UdDesign.init(context);
    return Scaffold(
      body: getBody(_currentIndex),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
        ),
        child: ClipRRect(
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
                      icon: Passets.homeIcon,
                      titleText: "Home",
                      currentIndex: 1),
                  label: ''),
              BottomNavigationBarItem(
                  icon: iconwithdesignmethod(
                      icon: Passets.searchIcon,
                      titleText: "Search",
                      currentIndex: 2),
                  label: ''),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconwithdesignmethod({icon, titleText, currentIndex}) {
    return _currentIndex == currentIndex
        ? Padding(
            padding: EdgeInsets.only(top: UdDesign.pt(8)),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: PColors.basicColor,
                      borderRadius: BorderRadius.circular(38),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: UdDesign.pt(5),
                        horizontal: UdDesign.pt(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            icon,
                            color: _currentIndex == currentIndex
                                ? Colors.white
                                : Colors.black,
                            height: UdDesign.pt(25),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: UdDesign.pt(8),
                              vertical: UdDesign.pt(8),
                            ),
                            child: Text(
                              titleText,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: UdDesign.fontSize(14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
