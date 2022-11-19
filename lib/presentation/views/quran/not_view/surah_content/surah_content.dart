import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/resources/assets_manager.dart';
import 'package:khetma/presentation/resources/styles_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../../controllers/quran/quran_bloc.dart';
import '../../../../../domain/models/faqra.dart';
import '../../../../resources/font_manager.dart';
import '../../../../util/util_manager.dart';
import 'package:quran/quran.dart' as quran;

import '../../views/faqra_view/surah_key_manager.dart';

class SurahContent extends StatelessWidget {
  final FaqraSurahModel surah;
  final AutoScrollController controller;
  final SurahKeyManager keyManager;
  final int werdIndex;

  SurahContent(
      {Key? key,
      required this.surah,
      required this.controller,
      required this.keyManager,
      this.werdIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title2(context),
        UtilM.box15(),
        showIsNotCompleted(),
        basmala(context),
        UtilM.box5(),
        ayatBuilder(context)
      ],
    );
  }

  Widget basmala(context) => BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (b, c) => (c is QSSliderFontEndChange || c is QSFontFamily),
        builder: (context, state) {
          return Text(
            quran.basmala,
            style: QuranBloc.get(context).quranStyle(),
          );
        },
      );

  Widget title2(context) => Stack(
        children: [
          Container(
            color: const Color(0xFFFFFFCC),
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    // alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsManager.tarwesaRightPng),
                      Positioned(
                          left: 25,
                          top: 32,
                          child: number(
                              getVerseEndSymbol(surah.id, useSymbol: false)))
                    ],
                  ),
                  Text(quran.getSurahNameArabic(surah.id),
                      style: const TextStyle(
                          fontFamily: FontConstant.fontAmiri, fontSize: 24)),
                  Stack(
                    // alignment: Alignment.center,
                    children: [
                      Image.asset(AssetsManager.tarwesaLeftPng),
                      Positioned(
                          right: 25,
                          top: 32,
                          child: number(getVerseEndSymbol(
                              quran.getVerseCount(surah.id),
                              useSymbol: false)))
                    ],
                  )
                ]),
          ),
          border(context)
        ],
      );

  // surah title
  Widget border(BuildContext context) =>
      oneTage(keyManager.indexOfAya(surah.id, 0, werdIndex),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff000000), width: 2),
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff0094A5), width: 6),
                  color: Colors.transparent,
                ),
                height: 50,
              )));

  Widget number(String num) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0xff0094A5),
        ),
        width: 30,
        height: 17,
        child: Center(
          child: Text(
            num,
            style: const TextStyle(
                color: Color(0x99000000),
                fontWeight: FontWeight.bold,
                fontSize: 13,
                letterSpacing: 0),
          ),
        ),
      );

  Widget ayatBuilder(BuildContext context, {int? ayaStart, int? ayaEnd}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (b, c) => (c is QSSliderFontEndChange || c is QSFontFamily),
        builder: (context, state) {
          ayaStart = surah.ayaStart;
          ayaEnd = surah.ayaEnd;
          return RichText(
            textAlign: TextAlign.justify,
            text:
                TextSpan(style: QuranBloc.get(context).quranStyle(), children: [
              for (int i = ayaStart!; i <= ayaEnd!; i++) ...[
                TextSpan(text: " ${quran.getVerse(surah.id, i)} "),
                // TextSpan(text: quran.getVerseEndSymbol(i)),
                WidgetSpan(
                    child: oneTage(
                  keyManager.indexOfAya(surah.id, i, werdIndex),
                  child: Text(getVerseEndSymbol(i),
                      style: StylesManager.quranTextStyle(
                          QuranBloc.get(context).fontValue,
                          FontConstant.fontAmiri)),
                ))
              ]
            ]),
          );
        },
      ),
    );
  }

  Widget oneTage(int index, {Widget? child}) => VisibilityDetector(
        key: ValueKey("key$index"),
        onVisibilityChanged: (VisibilityInfo info) {
          // log("${info.visibleFraction} of my widget is visible");
          var visiblePercentage = info.visibleFraction * 100;
          debugPrint('Widget ${index} is $visiblePercentage% visible ');
        },
        child: AutoScrollTag(
          key: ValueKey("key$index"),
          index: index,
          controller: controller,
          child: child,
        ),
      );

  String getVerseEndSymbol(int verseNumber, {bool useSymbol = true}) {
    var arabicNumeric = '';
    var digits = verseNumber.toString().split("").toList();

    for (var e in digits) {
      if (e == "0") {
        arabicNumeric += "٠";
      }
      if (e == "1") {
        arabicNumeric += "۱";
      }
      if (e == "2") {
        arabicNumeric += "۲";
      }
      if (e == "3") {
        arabicNumeric += "۳";
      }
      if (e == "4") {
        arabicNumeric += "٤";
      }
      if (e == "5") {
        arabicNumeric += "۵";
      }
      if (e == "6") {
        arabicNumeric += "٦";
      }
      if (e == "7") {
        arabicNumeric += "۷";
      }
      if (e == "8") {
        arabicNumeric += "۸";
      }
      if (e == "9") {
        arabicNumeric += "۹";
      }
    }
    if (!useSymbol) return arabicNumeric;
    return '\u06dd$arabicNumeric';
  }

  Widget showIsNotCompleted() {
    if (surah.ayaStart != 1 || surah.ayaEnd != quran.getVerseCount(surah.id)) {
      return Container(
        color: Colors.grey.shade100,
        width: double.infinity,
        child: Center(
            child: Text("من الأية : " +
                surah.ayaStart.toString() +
                " إلي الأية : " +
                surah.ayaEnd.toString())),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
