import 'dart:convert';

import 'package:reviewapp/features/review/data/models/review_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ReviewLocalDataSource {
  Future<List<ReviewModel>> getReviews();

  Future<void> saveReviews(List<ReviewModel> updatedReviews);
}

const String CACHED_REVIEWS = "CACHED_REVIEWS";

class ReviewLocalDataSourceImpl implements ReviewLocalDataSource {
  final SharedPreferences sharedPreferences;

  ReviewLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> saveReviews(List<ReviewModel> updatedReviews) async {
    List<String> reviewsStringList = [];

    for (ReviewModel review in updatedReviews) {
      Map<String, dynamic> reviewMap = review.toJson();
      String reviewString = jsonEncode(ReviewModel.fromJson(reviewMap));
      reviewsStringList.add(reviewString);
    }

    this.sharedPreferences.setStringList(CACHED_REVIEWS, reviewsStringList);
  }

  @override
  Future<List<ReviewModel>> getReviews() async {
    final List<String> reviewsStringList =
        this.sharedPreferences.getStringList(CACHED_REVIEWS) ?? [];
    final List<ReviewModel> retrievedReviews = [];

    for (String reviewString in reviewsStringList) {
      Map<String, dynamic> reviewMap = jsonDecode(reviewString);
      ReviewModel review = ReviewModel.fromJson(reviewMap);
      retrievedReviews.add(review);
    }

    return retrievedReviews;
  }
}
