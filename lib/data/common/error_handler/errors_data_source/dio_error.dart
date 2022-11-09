import 'package:dio/dio.dart';
import 'package:khetma/app/extensions.dart';
import '../error_handler.dart';
import '../failure.dart';
import 'other_errors.dart';

Failure handleDioError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSourceDioError.CONNECT_TIMEOUT.getFailure();
    case DioErrorType.sendTimeout:
      return DataSourceDioError.SEND_TIMEOUT.getFailure();
    case DioErrorType.receiveTimeout:
      return DataSourceDioError.RECIEVE_TIMEOUT.getFailure();
    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSourceOtherError.DEFAULT.getFailure();
      }
    case DioErrorType.cancel:
      return DataSourceDioError.CANCEL.getFailure();
    case DioErrorType.other:
      return DataSourceOtherError.DEFAULT.getFailure();
  }
}

enum DataSourceDioError {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
}

extension DataSourceExtension on DataSourceDioError {
  Failure getFailure() {
    switch (this) {
      case DataSourceDioError.SUCCESS:
        return Failure(ErrorCodes.SUCCESS, ErrorMessages.SUCCESS);
      case DataSourceDioError.NO_CONTENT:
        return Failure(
            ErrorCodes.NO_CONTENT, ErrorMessages.NO_CONTENT);
      case DataSourceDioError.BAD_REQUEST:
        return Failure(
            ErrorCodes.BAD_REQUEST, ErrorMessages.BAD_REQUEST);
      case DataSourceDioError.FORBIDDEN:
        return Failure(ErrorCodes.FORBIDDEN, ErrorMessages.FORBIDDEN);
      case DataSourceDioError.UNAUTORISED:
        return Failure(
            ErrorCodes.UNAUTORISED, ErrorMessages.UNAUTORISED);
      case DataSourceDioError.NOT_FOUND:
        return Failure(ErrorCodes.NOT_FOUND, ErrorMessages.NOT_FOUND);
      case DataSourceDioError.INTERNAL_SERVER_ERROR:
        return Failure(ErrorCodes.INTERNAL_SERVER_ERROR,
            ErrorMessages.INTERNAL_SERVER_ERROR);
      case DataSourceDioError.CONNECT_TIMEOUT:
        return Failure(
            ErrorCodes.CONNECT_TIMEOUT, ErrorMessages.CONNECT_TIMEOUT);
      case DataSourceDioError.CANCEL:
        return Failure(ErrorCodes.CANCEL, ErrorMessages.CANCEL);
      case DataSourceDioError.RECIEVE_TIMEOUT:
        return Failure(
            ErrorCodes.RECIEVE_TIMEOUT, ErrorMessages.RECIEVE_TIMEOUT);
      case DataSourceDioError.SEND_TIMEOUT:
        return Failure(
            ErrorCodes.SEND_TIMEOUT, ErrorMessages.SEND_TIMEOUT);
      case DataSourceDioError.CACHE_ERROR:
        return Failure(
            ErrorCodes.CACHE_ERROR, ErrorMessages.CACHE_ERROR);
      case DataSourceDioError.NO_INTERNET_CONNECTION:
        return Failure(ErrorCodes.NO_INTERNET_CONNECTION,
            ErrorMessages.NO_INTERNET_CONNECTION);

    }
  }
}