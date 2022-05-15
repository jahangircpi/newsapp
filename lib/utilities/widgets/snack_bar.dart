import 'package:flutter/material.dart';
import 'package:ud_design/ud_design.dart';

snackBarProject({required context, String? title}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(
      content: Container(
        height: UdDesign.pt(50),
        decoration: BoxDecoration(
          color: const Color(0XFFC72C41),
          borderRadius: BorderRadius.all(
            Radius.circular(UdDesign.pt(10)),
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 40),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Oh snap!'),
                  Text(
                    title!,
                    style: TextStyle(fontSize: UdDesign.fontSize(15)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}
