import 'package:dartz/dartz.dart';
import 'package:reviewapp/core/error/failures.dart';
import 'package:reviewapp/core/usecases/usecase.dart';
import 'package:reviewapp/features/review/data/models/review_model.dart';
import 'package:reviewapp/features/review/domain/repositories/review_repository.dart';

class GetReviewUC extends UseCase<List<ReviewModel>, NoParams> {
  final ReviewRepository repository;

  GetReviewUC(this.repository);

  @override
  Future<Either<Failure, List<ReviewModel>>> call(NoParams noParams) async {
    return await this.repository.getReviews();
  }
}
