import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khetma/app/temp_data.dart';
import 'package:khetma/controllers/home/home_bloc.dart';
import 'package:khetma/domain/models/cache_models.dart';
import 'package:khetma/presentation/util/util_manager.dart';

import '../../../../controllers/quran/quran_bloc.dart';
import '../../../../domain/models/faqra.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/font_manager.dart';
import '../../../resources/theme_manager.dart';
import '../../../resources/views_manager.dart';
import 'package:quran/quran.dart' as quran;

class AllSurahView extends StatelessWidget {
  AllSurahView({Key? key}) : super(key: key);
  String searchKey = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: UtilM.searchBar(onChanged: (d) {
          searchKey = d.toLowerCase();
          QuranBloc.get(context).changeSearch();
        }),
      ),
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
                for (int i = 1; i <= quran.totalSurahCount; i++)
                  if (isInSearch(i)) ...[
                    buildOneSurah(i, context),
                    const Divider(color: Colors.black, height: 3)
                  ]
              ],
            );
          },
        ),
      );

  Widget buildOneSurah(int sorahNumb, context) => SizedBox(
        height: 100,
        child: InkWell(
          onTap: () {
            ViewsManager.QuranContentWB(
                context,
                FaqraModel([
                  FaqraSurahModel(sorahNumb, 1, quran.getVerseCount(sorahNumb))
                ]));
            HomeBloc.get(context)
                .changeLastSurahRead(CacheLastSurahModel(sorahNumb, 1));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetsManager.bannerAyaSvg,
                          width: 40,
                          height: 40,
                        ),
                        Text("$sorahNumb")
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
                              quran.getSurahNameArabic(sorahNumb),
                              style: ThemeManager
                                  .currentThem.textTheme.bodyLarge
                                  ?.copyWith(
                                      fontFamily: FontConstant.fontAmiri),
                            ),
                            if (HomeBloc.get(context).lastSurahModel?.id ==
                                sorahNumb)
                              lastRead()
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              // Spacer(),
              getPlaceLogo(quran.getPlaceOfRevelation(sorahNumb) == "Makkah"),
              SizedBox(
                width: 150,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    quran.getSurahName(sorahNumb),
                    style: ThemeManager.currentThem.textTheme.bodyLarge
                        ?.copyWith(fontFamily: FontConstant.fontAmiri),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget lastRead() => const Text(
        "last read",
        style: TextStyle(color: Colors.lightGreen),
      );

  Widget getPlaceLogo(bool isMakah) => isMakah
      ? SvgPicture.asset(
          AssetsManager.makaSvg,
          width: 20,
        )
      : Image.asset(
          AssetsManager.madinaPng,
          width: 20,
        );

  bool isInSearch(int i) {
    return (quran.getSurahNameArabic(i).toString().contains(searchKey) ||
        quran.getSurahName(i).toString().toLowerCase().contains(searchKey));
  }
}
