import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:khetma/data/data_source/shared_pref/shared_pref_data_source.dart';
import 'package:khetma/domain/models/cache_models.dart';
import 'package:khetma/domain/repository/cache_repository.dart';

import '../common/error_handler/error_handler.dart';
import '../common/error_handler/failure.dart';

class SharedPrefKeys {
  static const lastSurah = "last_sorah";
  static const lastJoz = "last_joz";
  static const lastGroup = "last_group";
  static const allGroup = "all_groups";
}

class CacheRepoSharedPref implements CacheRepository {
  final SharedPrefDSTemp _prefDSTemp;

  CacheRepoSharedPref(this._prefDSTemp);

  // set

  @override
  Future<Either<Failure, bool>> setGroupLastSeen(
      CacheLastGroupModel? lG) async {
    if (lG == null) {
      return right(await _prefDSTemp.removeKey(SharedPrefKeys.lastGroup));
    }
    return _setObj(SharedPrefKeys.lastGroup, lG);
  }

  @override
  Future<Either<Failure, bool>> setJozLastSeen(CacheLastJozModel joz) async {
    return _setObj(SharedPrefKeys.lastJoz, joz);
  }

  @override
  Future<Either<Failure, bool>> setSurahLastSeen(CacheLastSurahModel s) async {
    return _setObj(SharedPrefKeys.lastSurah, s);
  }

  @override
  Future<Either<Failure, bool>> setAllGroups(CacheAllGroupModel allG) async {
    return _setObj(SharedPrefKeys.allGroup, allG);
  }

  // get
  @override
  Either<Failure, CacheLastGroupModel?> getGroupLastSeen() {
    try {
      String? s = _prefDSTemp.getString(SharedPrefKeys.lastGroup);
      if (s == null) return right(null);
      return right(CacheLastGroupModel.fromJson(jsonDecode(s)));
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Either<Failure, CacheLastJozModel?> getJozLastSeen() {
    try {
      String? s = _prefDSTemp.getString(SharedPrefKeys.lastJoz);
      if (s == null) return right(null);
      return right(CacheLastJozModel.fromJson(jsonDecode(s)));
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Either<Failure, CacheLastSurahModel?> getSurahLastSeen() {
    try {
      String? s = _prefDSTemp.getString(SharedPrefKeys.lastSurah);
      if (s == null) return right(null);
      return right(CacheLastSurahModel.fromJson(jsonDecode(s)));
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Either<Failure, CacheAllGroupModel> getAllGroups() {
    try {
      String? s = _prefDSTemp.getString(SharedPrefKeys.allGroup);
      if (s == null) return right(CacheAllGroupModel([]));
      return right(CacheAllGroupModel.fromJson(jsonDecode(s)));
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }

  // privet methods
  Future<Either<Failure, bool>> _setObj(String key, dynamic obj) async {
    try {
      return right(await _prefDSTemp.setString(key, json.encode(obj.toJson())));
    } catch (e) {
      return left(ErrorHandler.handle(e).failure);
    }
  }
}
