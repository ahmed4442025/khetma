// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faqra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FaqraModel _$FaqraModelFromJson(Map<String, dynamic> json) => FaqraModel(
      (json['listSurah'] as List<dynamic>)
          .map((e) => FaqraSurahModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FaqraModelToJson(FaqraModel instance) =>
    <String, dynamic>{
      'listSurah': instance.listSurah.map((e) => e.toJson()).toList(),
    };

FaqraSurahModel _$FaqraSurahModelFromJson(Map<String, dynamic> json) =>
    FaqraSurahModel(
      json['id'] as int,
      json['ayaStart'] as int,
      json['ayaEnd'] as int,
    );

Map<String, dynamic> _$FaqraSurahModelToJson(FaqraSurahModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ayaStart': instance.ayaStart,
      'ayaEnd': instance.ayaEnd,
    };

GroupQuran _$GroupQuranFromJson(Map<String, dynamic> json) => GroupQuran(
      FaqraModel.fromJson(json['faqraModel'] as Map<String, dynamic>),
      json['name'] as String,
    );

Map<String, dynamic> _$GroupQuranToJson(GroupQuran instance) =>
    <String, dynamic>{
      'faqraModel': instance.faqraModel.toJson(),
      'name': instance.name,
    };
