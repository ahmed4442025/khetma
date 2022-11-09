import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/quran/quran_bloc.dart';
import '../data/repository/cache_repo_shared_pref.dart';
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
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.firstScreen,
                theme: ThemeManager.currentThem);
          }),
    );
  }
}
