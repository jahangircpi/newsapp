import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

class TopAppBar extends StatelessWidget {
  final String fullcountryname;
  const TopAppBar({Key? key, required this.fullcountryname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: UdDesign.pt(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          fullcountryname,
          style:
              TextStyle(fontSize: UdDesign.fontSize(15), color: Colors.white),
        ),
        const SizedBox()
      ],
    );
  }
}
