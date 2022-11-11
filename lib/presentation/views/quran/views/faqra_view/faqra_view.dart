import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/util/util_manager.dart';
import 'package:khetma/presentation/views/quran/uti/mini_settings.dart';
import 'package:khetma/presentation/views/quran/uti/surah_content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../../../../../controllers/home/home_bloc.dart';
import '../../../../../controllers/quran/quran_bloc.dart';
import '../../../../../domain/models/cache_models.dart';
import '../../../../../domain/models/faqra.dart';
import '../../../../resources/views_manager.dart';

class FaqraView extends StatelessWidget {
  final FaqraData faqraData;

  FaqraView({Key? key, required this.faqraData}) : super(key: key);
  late final QuranBloc _cubit;
  late final BuildContext _context;
  final AutoScrollController _controller = AutoScrollController();
  bool isTimerRun = false;
  bool stopTimer = false;

  @override
  Widget build(BuildContext context) {
    _cubit = QuranBloc.get(context);
    _context = context;
    _cubit.resetMapKey();
    gotoLastPosition();
    if (!isTimerRun) checkIfStop();
    isTimerRun = true;

    return WillPopScope(
      onWillPop: () async {
        onBack();
        return true;
      },
      child: SafeArea(
          child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.yellow.shade50,
          body: body(),
          floatingActionButton: testWidget(context),
        ),
      )),
    );
  }

  // for debugging -> delete it it's ok
  Widget testWidget(context) => Row(children: [
        FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              onBack();
              ViewsManager.backIfUCan(context);
            },
            child: Icon(Icons.arrow_back_ios)),
        FloatingActionButton(onPressed: () {
          gotoLastPosition();
        }),
      ]);

  Widget body() {
    return Row(
      children: [
        Container(
          color: Colors.cyanAccent.withOpacity(.1),
          width: 25,
          child: RotatedBox(quarterTurns: 3, child: slider()),
        ),
        quranContent(),
        Container(
          color: Colors.cyanAccent.withOpacity(.1),
          width: 20,
        ),
      ],
    );
  }

  // ---------- quran content ----------
  Widget quranContent() => Expanded(
          child: Scrollbar(
        controller: _controller,
        interactive: true,
        thumbVisibility: true,
        child: ListView(
          controller: _controller,
          children: [
            MiniSetting(backVoid: onBack),
            UtilM.box20(),
            for (int i = 0; i < faqraData.faqraModel.listSurah.length; i++)
              SurahContent(
                  surah: faqraData.faqraModel.listSurah[i],
                  controller: _controller)
          ],
        ),
      ));

  // ----------------- slider speed -----------------
  Widget slider() => BlocBuilder<QuranBloc, QuranState>(
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
                autoScrollToEnd();
              },
            ),
          );
        },
      );

  // quran

  void autoScrollToEnd() {
    if(!_controller.hasClients)return;
    try {
      Duration? d = _cubit.timeToScroll(_controller);
      if (d == null) {
        _controller.animateTo(_controller.offset,
            duration: Duration.zero, curve: Curves.linear);
        return;
      }
      _controller.animateTo(_controller.position.maxScrollExtent,
          duration: d, curve: Curves.linear);
    } catch (e) {
      log("error : $e");
      stopTimer = true;
    }
  }

  Future checkIfStop() async {
    while(!stopTimer){
      await Future.delayed(const Duration(seconds: 3));
      log("timer");
      autoScrollToEnd();
      saveCurrentPosition();
    }

  }

  // check the content type and save the position of scroll controller
  void saveCurrentPosition() async {
    if (!await _isControllerAvailable()) return;
    if (!_context.mounted) return;
    HomeBloc cubitCache = HomeBloc.get(_context);
    switch (faqraData.faqraType) {
      case FaqraType.surah:
        updateSurah(cubitCache);
        break;
      case FaqraType.joz:
        // TODO: Handle this case.
        break;
      case FaqraType.werd:
        // TODO: Handle this case.
        break;
    }
  }

  // is view still opened
  Future<bool> _isControllerAvailable() async {
    await Future.delayed(Duration.zero);
    return _controller.hasClients;
  }

  // update surah position
  void updateSurah(HomeBloc cubitCache) {
    CacheLastSurahModel? newSurah = cubitCache.lastSurahModel;
    if (newSurah != null) {
      newSurah.offset = _controller.position.pixels;
      cubitCache.changeLastSurahRead(newSurah);
    }
  }

  // goto last position
  void gotoLastPosition() async {
    if (await _isControllerAvailable()) {
      _controller.animateTo(faqraData.lastOffest,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  void onBack() {
    stopTimer = true;
    saveCurrentPosition();
  }
}

// model carry all view parameters
class FaqraData {
  FaqraModel faqraModel;
  FaqraType faqraType;
  double lastOffest;

  FaqraData(this.faqraModel, this.faqraType, this.lastOffest);
}

// content type
enum FaqraType { surah, joz, werd }
