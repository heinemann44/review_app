import 'package:dartz/dartz.dart';
import 'package:reviewapp/core/error/failures.dart';
import 'package:reviewapp/core/network/network_info.dart';
import 'package:reviewapp/features/review/data/datasources/review_local_data_source.dart';
import 'package:reviewapp/features/review/domain/entities/review.dart';
import 'package:reviewapp/features/review/domain/repositories/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  ReviewLocalDataSource localDataSource;
  NetworkInfo networkInfo;

  ReviewRepositoryImpl({
    this.localDataSource,
    this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Review>>> getReviews() async{
    final reviews = await this.localDataSource.getReviews();
    return Right(reviews);
  }

  @override
  Future<Either<Failure, void>> saveReviews(List<Review> updatedReviews) async{
    final result = await this.localDataSource.saveReviews(updatedReviews);
    return Right(result);
  }
}
