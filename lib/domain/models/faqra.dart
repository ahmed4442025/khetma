import 'package:json_annotation/json_annotation.dart';

part 'faqra.g.dart';

@JsonSerializable(explicitToJson: true)
class FaqraModel {
  final List<FaqraSurahModel> listSurah;

  FaqraModel(this.listSurah);

  factory FaqraModel.fromJson(Map<String, dynamic> json) =>
      _$FaqraModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqraModelToJson(this);
}

@JsonSerializable()
class FaqraSurahModel {
  final int id;
  final int ayaStart;
  final int ayaEnd;

  FaqraSurahModel(this.id, this.ayaStart, this.ayaEnd);

  factory FaqraSurahModel.fromJson(Map<String, dynamic> json) =>
      _$FaqraSurahModelFromJson(json);

  Map<String, dynamic> toJson() => _$FaqraSurahModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GroupQuran {
  FaqraModel faqraModel;
  String name;

  GroupQuran(this.faqraModel, this.name);

  factory GroupQuran.fromJson(Map<String, dynamic> json) =>
      _$GroupQuranFromJson(json);

  Map<String, dynamic> toJson() => _$GroupQuranToJson(this);
}
