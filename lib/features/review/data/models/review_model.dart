
import 'package:reviewapp/features/review/domain/entities/review.dart';

class ReviewModel extends Review {
  ReviewModel({
    String comment,
    int stars,
  }) : super(comment: comment, stars: stars);

  factory ReviewModel.fromJson(Map<String, dynamic> parsedJson) {
    return ReviewModel(
      comment: parsedJson['comment'],
      stars: parsedJson['stars'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': this.comment,
      'stars': this.stars,
    };
  }
}
