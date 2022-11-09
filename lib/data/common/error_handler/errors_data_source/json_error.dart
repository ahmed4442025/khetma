import '../error_handler.dart';
import '../failure.dart';

Failure handleJsonError(FormatException error) {
  return Failure(ErrorCodes.unexpectedCharacter, "${error.message} ");
}
