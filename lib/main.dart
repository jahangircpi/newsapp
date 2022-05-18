import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:newsapp/controllers/home_controller.dart';
import 'package:newsapp/controllers/search_controller.dart';
import 'package:newsapp/controllers/world_controller.dart';
import 'package:newsapp/utilities/constants/colors.dart';
import 'package:newsapp/utilities/functions/navigations.dart';
import 'package:newsapp/views/root.dart';
import 'package:provider/provider.dart';
import 'controllers/favorite_controller.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          return null;
        },
      ));
    }
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<FavoriteController>(
      create: (_) => FavoriteController(),
    ),
    ChangeNotifierProvider<HomeController>(
      create: (_) => HomeController(),
    ),
    ChangeNotifierProvider<WorldController>(
      create: (_) => WorldController(),
    ),
    ChangeNotifierProvider<SearchController>(
      create: (_) => SearchController(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      key: navKey,
      title: 'NewsApp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: PColors.backgrounColor),
      home: const RootScreen(),
    );
  }
}
