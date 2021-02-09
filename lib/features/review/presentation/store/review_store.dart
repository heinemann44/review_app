import 'package:mobx/mobx.dart';
import 'package:reviewapp/core/usecases/usecase.dart';
import 'package:reviewapp/features/review/data/models/review_model.dart';
import 'package:reviewapp/features/review/domain/usecases/get_reviews_uc.dart';
import 'package:reviewapp/features/review/domain/usecases/save_review_uc.dart';

part 'review_store.g.dart';

class ReviewStore = _ReviewStore with _$ReviewStore;

abstract class _ReviewStore with Store {
  final SaveReviewUC saveReviewUC;
  final GetReviewUC getReviewUC;

  _ReviewStore({
    this.saveReviewUC,
    this.getReviewUC,
  });

  @observable
  ObservableList<ReviewModel> reviews = ObservableList.of([]);

  @observable
  double averageStars = 0;

  @computed
  int get numberOfReviews => this.reviews.length;

  @computed
  bool get haveReviews => this.reviews?.isNotEmpty ?? false;

  int totalStars = 0;

  @action
  void addReview(ReviewModel newReview) {
    this.reviews.add(newReview);
    this.averageStars = this._calculateAverageStars(stars: newReview.stars);
    this.totalStars += newReview.stars;
    this.saveReviewUC(this.reviews);
  }

  double _calculateAverageStars({int stars = 0}) {
    return (stars + this.totalStars) / this.reviews.length;
  }

  @action
  Future<void> initReviews() async {
    final reviewsEither = await this.getReviewUC(NoParams());
    reviewsEither.fold((failure) => null, (values) {
      this.reviews = ObservableList.of(values);
    });

    for (ReviewModel review in this.reviews) {
      this.totalStars += review.stars;
    }

    this.averageStars = this._calculateAverageStars();
  }
}
