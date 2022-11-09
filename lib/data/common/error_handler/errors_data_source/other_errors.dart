import '../error_handler.dart';
import '../failure.dart';

enum DataSourceOtherError { assetNotFound, DEFAULT }

Failure handleOthrtError(DataSourceOtherError error) {
  switch (error) {
    case DataSourceOtherError.assetNotFound:
      return DataSourceOtherError.assetNotFound.getFailure();
    case DataSourceOtherError.DEFAULT:
      return DataSourceOtherError.DEFAULT.getFailure();
  }
}

extension DataSourceExtension on DataSourceOtherError {
  Failure getFailure() {
    switch (this) {
      case DataSourceOtherError.DEFAULT:
        return Failure(ErrorCodes.DEFAULT, ErrorMessages.DEFAULT);
      case DataSourceOtherError.assetNotFound:
        return Failure(ErrorCodes.assetNotFound, ErrorMessages.assetNotFound);
    }
  }
}
