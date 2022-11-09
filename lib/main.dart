import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khetma/data/data_source/shared_pref/shared_pref_data_source.dart';
import 'package:khetma/data/repository/cache_repo_shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'domain/models/cache_models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DateTime now = DateTime.now();
  await initAppModule();

  print("init : ${DateTime.now().difference(now).inMilliseconds} ms");

  runApp(MyApp());
}

