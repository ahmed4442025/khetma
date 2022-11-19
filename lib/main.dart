import 'dart:developer';

import 'package:flutter/material.dart';
import 'app/app.dart';
import 'app/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DateTime now = DateTime.now();
  await initAppModule();
  log("init : ${DateTime.now().difference(now).inMilliseconds} ms");

  runApp(MyApp());
}
