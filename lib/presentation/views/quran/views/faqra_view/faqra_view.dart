import 'dart:developer';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/util/util_manager.dart';
import 'package:khetma/presentation/views/quran/views/faqra_view/faqra_view_model.dart';
import 'package:khetma/presentation/views/quran/views/faqra_view/surah_key_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../../controllers/quran/quran_bloc.dart';
import '../../../../resources/views_manager.dart';
import '../../not_view/mini_settings.dart';
import '../../not_view/surah_content/surah_content.dart';

class FaqraView extends StatelessWidget {
  final FaqraData faqraData;

  FaqraView({Key? key, required this.faqraData}) : super(key: key);
  late final QuranBloc _cubit;

  // late final BuildContext _context;
  final AutoScrollController _controller = AutoScrollController();
  late final FaqraViewModel _model;

  @override
  Widget build(BuildContext context) {
    _cubit = QuranBloc.get(context);
    SurahKeyManager keyManager = SurahKeyManager();
    _model = FaqraViewModel(_controller, context, faqraData);
    _model.init();
    return WillPopScope(
      onWillPop: () async {
        _model.onBack();
        return true;
      },
      child: SafeArea(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.yellow.shade50,
              body: body(keyManager),
              floatingActionButton: testWidget(context),
            ),
          )),
    );
  }

  // for debugging -> delete it it's ok
  Widget testWidget(context) =>
      Row(children: [
        FloatingActionButton(
            heroTag: "btn1",
            onPressed: () async {
              _model.onBack();
              ViewsManager.backIfUCan(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        FloatingActionButton(onPressed: () {
          _model.gotoLastPosition();
        }),
      ]);

  Widget body(keyManager) {
    return Row(
      children: [
        Container(
          color: Colors.cyanAccent.withOpacity(.1),
          width: 25,
          child: RotatedBox(quarterTurns: 3, child: slider()),
        ),
        quranContent(keyManager),
        Container(
          color: Colors.cyanAccent.withOpacity(.1),
          width: 20,
        ),
      ],
    );
  }

  // ---------- quran content ----------
  Widget quranContent(keyManager) =>
      Expanded(
          child: Scrollbar(
            controller: _controller,
            interactive: true,
            thumbVisibility: true,
            child: ListView(
              controller: _controller,
              children: [
                MiniSetting(backVoid: _model.onBack),
                UtilM.box20(),
                for (int i = 0; i < faqraData.faqraModel.listSurah.length; i++)
                  SurahContent(
                    surah: faqraData.faqraModel.listSurah[i],
                    controller: _controller,
                    keyManager: keyManager, //todo
                    werdIndex: _model.werdIndex(i),
                  )
              ],
            ),
          ));

  // ----------------- slider speed -----------------
  Widget slider() =>
      BlocBuilder<QuranBloc, QuranState>(
        buildWhen: (previous, current) {
          return (current is QSSlider);
        },
        builder: (context, state) {
          return SliderTheme(
            data: const SliderThemeData(
              trackHeight: 1,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 5.0),
            ),
            child: Slider(
              activeColor: Colors.pinkAccent,
              inactiveColor: Colors.grey,
              min: _cubit.sliderSpeedMinValue,
              max: _cubit.sliderSpeedMaxValue,
              value: _cubit.sliderSpeedValue,
              onChanged: (v) => _cubit.changeSliderSpeedValue(v),
              onChangeEnd: (v) {
                _cubit.changeSpeed(v);
                _model.autoScrollToEnd();
              },
            ),
          );
        },
      );
}
