import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khetma/presentation/resources/color_manager.dart';
import 'package:khetma/presentation/resources/theme_manager.dart';
import 'package:quran/quran.dart' as quran;
import 'package:scroll_to_index/scroll_to_index.dart';

import '../resources/font_manager.dart';

class TempTestScroll extends StatefulWidget {
  const TempTestScroll({Key? key}) : super(key: key);

  @override
  State<TempTestScroll> createState() => _TempTestScrollState();
}

class _TempTestScrollState extends State<TempTestScroll> {
  // final scrollC = ScrollController();
  double speedScroll = 0;
  // final ScrollController _controller = ScrollController();
  AutoScrollController _c2 = AutoScrollController();
  int maxIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: testLib(),
        floatingActionButton: FloatingActionButton(
          onPressed: flB,
        ),
      ),
    );
  }

  Widget testLib() {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        ayatBuilder(2)
      ],
    );
  }

  var keys = List.generate(1000, (i) => GlobalKey());

  Widget ayatBuilder(int surahId, {int? ayaStart, int? ayaEnd}) {
    print("build ayat | max index = $maxIndex");
    ayaStart = ayaStart ?? 1;
    ayaEnd = ayaEnd ?? quran.getVerseCount(surahId);
    return Expanded(
      child: Container(
        // height: 500,
        color: Colors.yellow.shade50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            controller: _c2,
            children: [
              RichText(
                textAlign: TextAlign.justify,

                // textScaleFactor: 2,
                text: TextSpan(
                    style: TextStyle(
                        color: ThemeManager.c.fontMain,
                        fontFamily: FontConstant.fontAmiri,
                        fontSize: 20),
                    children: [
                      for (int i = ayaStart; i <= ayaEnd; i++) ...[
                        TextSpan(text: " ${quran.getVerse(surahId, i)} "),
                        // WidgetSpan(child: Text(" ${quran.getVerse(surahId, i)} ")),
                        WidgetSpan(
                            child: oneTage(
                          indexGen(surahId, i),
                          child: Text(quran.getVerseEndSymbol(i),
                              style: TextStyle(
                                  color: ThemeManager.c.fontMain,
                                  fontFamily: FontConstant.fontAmiri,
                                  fontSize: 20)),
                        )),
                        // TextSpan(text: quran.getVerseEndSymbol(i)),
                      ],
                      TextSpan(text: "")
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget oneTage(int index, {Widget? child}) => AutoScrollTag(
        key: ValueKey("key$index"),
        index: index,
        controller: _c2,
        child: child,
      );

  // voids

  void flB() {
    testScrollWithSpeed();
    // indexTo();
  }

  void changeTheme() {
    ThemeManager.changeColor(ColorsData.purple);
  }

  void indexTo() {
    _c2.scrollToIndex(20, preferPosition: AutoScrollPosition.end);
    print(_c2.position.maxScrollExtent);
    print(_c2.offset);
    // print(_c2);
    print(maxIndex);
    print("index to ");
  }

  void testScrollWithSpeed() {
    double speed = .00003*1000000;
    double maxPosition = _c2.position.maxScrollExtent;
    double diffPosition =_c2.position.maxScrollExtent - _c2.offset;
    print(diffPosition);
    int mSec = diffPosition ~/ speed;
    print("mSec : $mSec");

    _c2.animateTo(maxPosition,
        duration: Duration(seconds: mSec), curve: Curves.linear);
  }

  Map<int, int> mapKeys = {};

  int indexGen(int surahId, int ayaId) {
    int key = surahId * 1000 + ayaId;
    if (!mapKeys.containsKey(key)) {
      mapKeys[key] = ++maxIndex;
    }
    return mapKeys[key] ?? -1;
  }
}
