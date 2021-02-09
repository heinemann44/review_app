import 'package:equatable/equatable.dart';

class Review extends Equatable{
  final String comment;
  final int stars;

  Review({
    this.comment,
    this.stars,
  }): super([comment, stars]);
}
