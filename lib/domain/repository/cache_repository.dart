import 'package:dartz/dartz.dart';
import 'package:khetma/domain/models/cache_models.dart';
import 'package:khetma/domain/models/faqra.dart';

import '../../data/common/error_handler/failure.dart';

abstract class CacheRepository {
  // get
  Either<Failure, CacheLastSurahModel?> getSurahLastSeen();

  Either<Failure, CacheLastGroupModel?> getGroupLastSeen();

  Either<Failure, CacheLastJozModel?> getJozLastSeen();

  Either<Failure, CacheAllGroupModel> getAllGroups();

  // set

  Future<Either<Failure, bool>> setSurahLastSeen(
      CacheLastSurahModel cacheLastSurahModel);

  Future<Either<Failure, bool>> setJozLastSeen(
      CacheLastJozModel cacheLastJozModel);

  Future<Either<Failure, bool>> setGroupLastSeen(
      CacheLastGroupModel? cacheLastGroupModel);

  Future<Either<Failure, bool>> setAllGroups(
      CacheAllGroupModel cacheAllGroupModel);
}
