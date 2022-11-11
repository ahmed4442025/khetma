import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khetma/presentation/util/util_manager.dart';
import 'package:khetma/presentation/views/quran/uti/mini_settings.dart';
import 'package:khetma/presentation/views/quran/uti/surah_content.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../controllers/quran/quran_bloc.dart';
import '../../../../domain/models/faqra.dart';

class FaqraTestView extends StatelessWidget {
  final FaqraModel faqraModel;

  FaqraTestView({Key? key, required this.faqraModel}) : super(key: key);
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
    if (!isTimerRun) checkIfStop();
    isTimerRun = true;
    return SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.yellow.shade50,
            body: body2(),
          ),
        ));
  }

  Widget body2() => CustomScrollView(
    controller: _controller,
    slivers: [
      SliverAppBar(
        title: Text("App Bar"),
        floating: true,
        snap: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.amberAccent,
                  child: Text("Container 1")),
              Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.green,
                  child: Text("Container 1"))
            ],
          ),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
            MiniSetting(),
            UtilM.box20(),
            for (int i = 0; i < faqraModel.listSurah.length; i++)
              SurahContent(
                  surah: faqraModel.listSurah[i], controller: _controller)
          ])),
    ],
  );

  Widget body() => Row(
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

  // ---------- quran content ----------
  Widget quranContent() => Expanded(
      child: Scrollbar(
        controller: _controller,
        interactive: true,
        thumbVisibility: true,
        child: ListView(
          controller: _controller,
          children: [
            MiniSetting(),
            UtilM.box20(),
            for (int i = 0; i < faqraModel.listSurah.length; i++)
              SurahContent(
                  surah: faqraModel.listSurah[i], controller: _controller)
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

  void test() {
    autoScrollToEnd();
  }

  void autoScrollToEnd() {
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
      stopTimer = true;
    }
  }

  Future checkIfStop() async {
    await Future.delayed(const Duration(seconds: 3));
    if (stopTimer) return;
    autoScrollToEnd();
    await checkIfStop();
  }
}
