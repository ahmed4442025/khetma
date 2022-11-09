import 'package:dio/dio.dart';

import '../../../presentation/resources/strings_manager.dart';
import 'errors_data_source/dio_error.dart';
import 'failure.dart';
import 'errors_data_source/json_error.dart';
import 'errors_data_source/other_errors.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    // dio error so its an error from response of the API or from dio itself
    if (error is DioError) {
      failure = handleDioError(error);
    }
    // json error parser
    else if (error is FormatException) {
      failure = handleJsonError(error);
    }
    // json error parser
    else if (error is DataSourceOtherError) {
      failure = handleOthrtError(error);
    }
    // default error
    else {
      failure = DataSourceOtherError.DEFAULT.getFailure();
    }
  }
}

class ErrorCodes {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
  static const int NOT_FOUND = 404; // failure, not found

  // local status code
  static const int DEFAULT = -1;

  //      ------ DIO ------
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int CONNECT_TIMEOUT = -7;

  //      ------ JSON ------
  static const int unexpectedCharacter = -7;

  // other errors
  static const int assetNotFound = -8;
}

class ErrorMessages {
  static const String SUCCESS = AppStrings.success; // success with data
  static const String NO_CONTENT =
      AppStrings.success; // success with no data (no content)
  static const String BAD_REQUEST =
      AppStrings.badRequestError; // failure, API rejected request
  static const String UNAUTORISED =
      AppStrings.unauthorizedError; // failure, user is not authorised
  static const String FORBIDDEN =
      AppStrings.forbiddenError; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      AppStrings.internalServerError; // failure, crash in server side
  static const String NOT_FOUND =
      AppStrings.notFoundError; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = AppStrings.timeoutError;
  static const String CANCEL = AppStrings.defaultError;
  static const String RECIEVE_TIMEOUT = AppStrings.timeoutError;
  static const String SEND_TIMEOUT = AppStrings.timeoutError;
  static const String CACHE_ERROR = AppStrings.cacheError;
  static const String NO_INTERNET_CONNECTION = AppStrings.noInternetError;

  // json
  static const String unexpectedCharacter = AppStrings.parsingJsonErr;

  // other errors
  // static const String decryptLengthErr = AppStrings.decryptLengthErr;
  static const String DEFAULT = AppStrings.defaultError;
  static const String assetNotFound = AppStrings.assetNotFound;
}
