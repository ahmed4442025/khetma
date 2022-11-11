import 'faqra.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cache_models.g.dart';

class CacheLastSurahModel {
  int? id;
  int? aya;
  double? offset;


  CacheLastSurahModel(this.id, this.aya, this.offset);

  CacheLastSurahModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    aya = json["aya"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["aya"] = aya;
    data["offset"] = offset;
    return data;
  }

}

class CacheLastJozModel {
  int? id;
  int? surahId;
  int? aya;


  CacheLastJozModel(this.id, this.surahId, this.aya);

  CacheLastJozModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    surahId = json["surahId"];
    aya = json["aya"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    data["surahId"] = surahId;
    data["aya"] = aya;
    return data;
  }
}

class CacheLastGroupModel {
  int? id;

  CacheLastGroupModel(this.id);

  CacheLastGroupModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["id"] = id;
    return data;
  }
}

@JsonSerializable(explicitToJson: true)
class CacheAllGroupModel{
  List<GroupQuran> listGroups;

  CacheAllGroupModel(this.listGroups);

  factory CacheAllGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CacheAllGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$CacheAllGroupModelToJson(this);

}