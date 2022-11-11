import 'package:flutter/material.dart';
import 'package:khetma/presentation/temp/temp2.dart';
import 'package:khetma/presentation/views/quran/views/faqra_view/faqra_view.dart';

import '../../domain/models/faqra.dart';
import '../temp/temp.dart';
import '../views/home/home_view.dart';
import '../views/quran/views/favorites/add_group.dart';
import '../views/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String home = "/home";
  static const String temp = "/temp";
  static const String temp2 = "/temp2";
  static const String addNewGroupView = "/AddNewGroupView";
  static const String splashRout = "splash";
  static const String surahView = "/surahView";

  // static const String splashRout = "/";

  // home
  static const String firstScreen = splashRout;
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRout:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      // home
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());
      // surah content
      case Routes.surahView:
        return MaterialPageRoute(
            builder: (_) => FaqraView(
                  faqraData: settings.arguments as FaqraData,
                ));
      case Routes.addNewGroupView:
        return MaterialPageRoute(
            builder: (_) => AddNewGroupView(
                  groupIndex: settings.arguments as int?,
                ));
      // delete it --> (just for test)
      case Routes.temp:
        return MaterialPageRoute(builder: (_) => const TempView());
      case Routes.temp2:
        return MaterialPageRoute(builder: (_) => const TempTestScroll());

      default:
        return _unDefinedRout();
    }
  }

  static Route<dynamic> _unDefinedRout() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(
                child: Text(AppStrings.noRouteFound),
              ),
            ));
  }
}
