import 'dart:async';
import 'package:flutter/material.dart';
import '../../app/app_constants.dart';
import '../resources/views_manager.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Timer? _timer1;

  _startDelay() {
    _timer1 = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  void _goNext() {
    ViewsManager.homeAfterSplash(context);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    print("Splash View");
    return const Scaffold(
      // backgroundColor: ColorManager.primary,
        body: Center(
          child: Text("welcome"),
        ));
  }

  @override
  void dispose() {
    _timer1?.cancel();
    super.dispose();
  }
}
