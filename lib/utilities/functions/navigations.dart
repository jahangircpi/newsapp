import 'package:flutter/material.dart';

GlobalKey<NavigatorState>? navKey = GlobalKey();
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final globalKey = GlobalKey<ScaffoldMessengerState>();

void push({required Widget screen, required context}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushReplacement({required Widget screen}) {
  Navigator.pushReplacement(
    navKey!.currentContext!,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void pushAndRemoveUntil({required Widget screen}) {
  Navigator.pushAndRemoveUntil(
      navKey!.currentContext!,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false);
}

void pop({required BuildContext context}) {
  Navigator.pop(context);
}

void popWith({required BuildContext context, required bool value}) {
  Navigator.pop(context, value);
}
