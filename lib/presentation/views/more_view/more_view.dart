import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("more home")),
      body:myBody(),
    );
  }

  Widget myBody() => Center(child: Text("المزيد"),);
}
