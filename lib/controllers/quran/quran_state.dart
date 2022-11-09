part of 'quran_bloc.dart';

@immutable
abstract class QuranState {}

class QuranInitial extends QuranState {}

// test
class QSTest extends QuranState {}

// speed scroll
class QSSlider extends QuranState {}

class QSSpeedSlider extends QuranState {}

// font changer
class QSSliderFontChange extends QuranState {}

class QSSliderFontEndChange extends QuranState {}
class QSFontFamily extends QuranState {}

// home quran
class QSMainSearch extends QuranState {}


