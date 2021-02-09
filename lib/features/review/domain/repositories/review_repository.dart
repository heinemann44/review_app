import 'package:dartz/dartz.dart';
import 'package:reviewapp/core/error/failures.dart';
import 'package:reviewapp/features/review/domain/entities/review.dart';

abstract class ReviewRepository {
  Future<Either<Failure, List<Review>>> getReviews();

  Future<Either<Failure, void>> saveReviews(List<Review> updatedReviews);
}
