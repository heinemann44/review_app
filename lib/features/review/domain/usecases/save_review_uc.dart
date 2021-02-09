import 'package:dartz/dartz.dart';
import 'package:reviewapp/core/error/failures.dart';
import 'package:reviewapp/core/usecases/usecase.dart';
import 'package:reviewapp/features/review/data/models/review_model.dart';
import 'package:reviewapp/features/review/domain/repositories/review_repository.dart';

class SaveReviewUC extends UseCase<void, List<ReviewModel>> {
  final ReviewRepository repository;

  SaveReviewUC(this.repository);

  @override
  Future<Either<Failure, void>> call(List<ReviewModel> updatedReviews) async {
    return await this.repository.saveReviews(updatedReviews);
  }
}
