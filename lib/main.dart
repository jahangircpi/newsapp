import 'package:flutter/material.dart';
import 'package:newsapp/controllers/newscontroller.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<NewsController>(create: (_) => NewsController())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navKey!,
      title: 'NewsApp Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
