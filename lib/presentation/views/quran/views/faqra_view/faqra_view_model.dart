import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:khetma/controllers/quran/quran_bloc.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import '../../../../../controllers/home/home_bloc.dart';
import '../../../../../domain/models/cache_models.dart';
import '../../../../../domain/models/faqra.dart';

class FaqraViewModel {
  final AutoScrollController _controller;
  final BuildContext _context;
  final FaqraData faqraData;

  FaqraViewModel(this._controller, this._context, this.faqraData);

  late QuranBloc _cubit;
  bool _isTimerRun = false;
  bool _stopTimer = false;

  void init() {
    _cubit = QuranBloc.get(_context);
    gotoLastPosition();
    if (!_isTimerRun) checkIfStop();
    _isTimerRun = true;
  }

  // auto scroll to end
  void autoScrollToEnd() {
    if (!_controller.hasClients) return;
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
      _stopTimer = true;
    }
  }

  // timer
  Future checkIfStop() async {
    if (_isTimerRun) return;

    while (!_stopTimer) {
      await Future.delayed(const Duration(seconds: 3));
      // log("timer");
      if (!await _isControllerAvailable()) return;
      autoScrollToEnd();
      saveCurrentPosition();
    }
  }

  // check the content type and save the position of scroll controller
  void saveCurrentPosition() async {
    // todo
    // while (true){
    //   updateSurah(HomeBloc.get(_context));
    // }
    if (!await _isControllerAvailable()) return;
    // if (!_context.mounted) return; // todo removed

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
    _stopTimer = true;
    saveCurrentPosition();
  }

  // werd index
  int werdIndex(int index) {
    if (faqraData.faqraType == FaqraType.werd) {
      return index;
    }
    return 0;
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
