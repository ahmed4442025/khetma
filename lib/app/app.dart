import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import '../controllers/quran/quran_bloc.dart';
import '../presentation/resources/routes_maneger.dart';
import '../presentation/resources/theme_manager.dart';
import 'di.dart';

class MyApp extends StatefulWidget {
  // named constructor
  MyApp._internal();

  int appState = 0;

  static final MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => instance<QuranBloc>()),
        BlocProvider(create: (context) => instance<HomeBloc>()),
      ],
      child: StreamBuilder<bool>(
          stream: ThemeManager.outThemeChanged,
          builder: (context, snapshot) {
            return MaterialApp(
                scrollBehavior: MyCustomScrollBehavior(),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.firstScreen,
                theme: ThemeManager.currentThem);
          }),
    );
  }
}
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.invertedStylus,
    PointerDeviceKind.unknown,
    // etc.
  };
}