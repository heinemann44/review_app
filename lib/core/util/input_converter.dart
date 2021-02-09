import 'package:dartz/dartz.dart';
import 'package:reviewapp/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final value = int.tryParse(string);

      if (value < 0) throw FormatException();

      return Right(value);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
