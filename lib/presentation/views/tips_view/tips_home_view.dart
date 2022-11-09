import 'package:flutter/material.dart';

class TipsHomeView extends StatelessWidget {
  const TipsHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("tips home")),
      body:myBody(),
    );
  }

  Widget myBody() => Center(child: Text("نصائح"),);
}
