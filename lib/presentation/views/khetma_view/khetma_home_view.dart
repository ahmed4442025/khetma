import 'package:flutter/material.dart';

class KhetmaHomeView extends StatelessWidget {
  const KhetmaHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("khetma home")),
      body:myBody(),
    );
  }

  Widget myBody() => Center(child: Text("ختمة"),);
}
