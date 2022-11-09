// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CacheAllGroupModel _$CacheAllGroupModelFromJson(Map<String, dynamic> json) =>
    CacheAllGroupModel(
      (json['listGroups'] as List<dynamic>)
          .map((e) => GroupQuran.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CacheAllGroupModelToJson(CacheAllGroupModel instance) =>
    <String, dynamic>{
      'listGroups': instance.listGroups.map((e) => e.toJson()).toList(),
    };
