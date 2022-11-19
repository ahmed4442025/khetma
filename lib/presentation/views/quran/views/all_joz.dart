import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import 'package:khetma/domain/models/cache_models.dart';

import '../../../../controllers/quran/quran_bloc.dart';
import '../../../../domain/models/faqra.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/theme_manager.dart';
import '../../../resources/views_manager.dart';
import '../../../util/util_manager.dart';
import 'package:quran/quran.dart' as quran;

import 'package:khetma/presentation/views/quran/views/faqra_view/faqra_view_model.dart';

class AllJozView extends StatelessWidget {
  AllJozView({Key? key}) : super(key: key);
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myBody(context),
    );
  }

  Widget myBody(context) {
    return listSurah(context);
  }

  Widget listSurah(context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<QuranBloc, QuranState>(
          buildWhen: (p, c) => c is QSMainSearch,
          builder: (context, state) {
            return ListView(
              children: [
                for (int i = 1; i <= quran.totalJuzCount; i++) ...[
                  buildOneJoz(i, context),
                  const Divider(
                    color: Colors.black,
                    height: 3,
                  )
                ]
              ],
            );
          },
        ),
      );

  Widget buildOneJoz0(int i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("الجزء $i"),
          Text("Juz' $i"),
        ],
      ),
    );
  }

  Widget buildOneJoz(int i, context) => SizedBox(
        height: 100,
        child: InkWell(
          onTap: () => openJoz(context, i),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetsManager.bannerAyaSvg,
                        width: 40,
                        height: 40,
                      ),
                      Text("$i")
                    ],
                  ),
                  UtilM.box20(),
                  BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (p, c) => c is HSLastRead,
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "الجزء ${jozNames[i]}",
                            style: ThemeManager.currentThem.textTheme.bodyLarge
                                ?.copyWith(fontFamily: FontConstant.fontAmiri),
                          ),
                          if (HomeBloc.get(context).lastJozModel?.id == i)
                            lastRead()
                        ],
                      );
                    },
                  )
                ],
              ),
              Text(
                "juz' ${i}",
                style: ThemeManager.currentThem.textTheme.bodyLarge
                    ?.copyWith(fontFamily: FontConstant.fontAmiri),
              ),
            ],
          ),
        ),
      );

  FaqraModel jozToFaqra(int i) {
    List<FaqraSurahModel> s = [];
    quran.getSurahAndVersesFromJuz(i).forEach((key, value) {
      s.add(FaqraSurahModel(key, value[0], value[1]));
    });
    return FaqraModel(s);
  }

  Widget lastRead() => const Text(
        "last read",
        style: TextStyle(color: Colors.lightGreen),
      );

  // void open joz
  void openJoz(context, int i) {
    FaqraData faqraData = FaqraData(jozToFaqra(i), FaqraType.joz, 0); //todo
    ViewsManager.QuranContentWB(context, faqraData);
    // cache last joz
    HomeBloc.get(context).changeLastJozRead(CacheLastJozModel(
        i, jozToFaqra(i).listSurah[0].id, jozToFaqra(i).listSurah[0].ayaStart));
  }

  final List<String> jozNames = [
    '',
    'الأول',
    'الثاني',
    'الثالث',
    'الرابع',
    'الخامس',
    'السادس',
    'السابع',
    'الثامن',
    'التاسع',
    'العاشر',
    'الحادي عشر',
    'الثاني عشر',
    'الثالث عشر',
    'الرابع عشر',
    'الخامس عشر',
    'السادس عشر',
    'السابع عشر',
    'الثامن عشر',
    'التاسع عشر',
    'العشرون',
    'الحادي والعشرون',
    'الثاني والعشرون',
    'الثالث والعشرون',
    'الرابع والعشرون',
    'الخامس والعشرون',
    'السادس والعشرون',
    'السابع والعشرون',
    'الثامن والعشرون',
    'التاسع والعشرون',
    'الثلاثون',
  ];
}
