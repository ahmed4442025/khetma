import '../domain/models/faqra.dart';

class TempData {
  static List<GroupQuran> alwerd = [
    GroupQuran(
        FaqraModel([
          FaqraSurahModel(1, 1, 7),
          FaqraSurahModel(2, 200, 205),
          FaqraSurahModel(5, 1, 55),
          FaqraSurahModel(5, 1, 55),
          FaqraSurahModel(5, 1, 55),
          FaqraSurahModel(5, 1, 55),
        ]),
        "ورد رقم 1"),
    GroupQuran(
        FaqraModel([
          FaqraSurahModel(1, 1, 2),
          FaqraSurahModel(2, 1, 5),
          FaqraSurahModel(3, 1, 55),
          FaqraSurahModel(3, 1, 55),
          FaqraSurahModel(3, 1, 55),
          FaqraSurahModel(3, 1, 55),
        ]),
        "ورد رقم 2"),
  ];
}

// class TempCacheData{
//   static int? lastSurahOpened ;
//   static int? lastJozOpened ;
//   static int? lastGroupOpened ;
// }