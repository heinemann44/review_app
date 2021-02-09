import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:reviewapp/features/review/data/models/review_model.dart';
import 'package:reviewapp/features/review/presentation/store/review_store.dart';
import 'package:reviewapp/features/review/presentation/widgets/info_card.dart';
import 'package:reviewapp/features/review/presentation/widgets/review_item.dart';

class ReviewPage extends StatefulWidget {
  @override
  ReviewPageState createState() {
    return new ReviewPageState();
  }
}

class ReviewPageState extends State<ReviewPage> {
  final List<int> _stars = [1, 2, 3, 4, 5];
  ReviewStore reviewStore;
  TextEditingController _commentController;
  int _selectedStar;

  @override
  void initState() {
    super.initState();
    this.reviewStore = ReviewStore();
    this._commentController = TextEditingController();
  }

  @override
  void dispose() {
    this._commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review App'),
      ),
      body: this._buildBody(),
    );
  }

  Widget _buildBody() {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                width: screenWidth * 0.6,
                child: this._buildCommentField(),
              ),
              this._buildSelectStarsDropDown(),
              this._buildButton(),
            ],
          ),
          SizedBox(height: 12.0),
          Observer(builder: (context) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                this._buildReviewInfoCard(),
                this._buildAverageStarsInfoCard(),
              ],
            );
          }),
          SizedBox(height: 24.0),
          this._buildReviewMenu(),
          this._buildReviewList(),
        ],
      ),
    );
  }

  Widget _buildCommentField() {
    return TextField(
      controller: _commentController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        hintText: "Write a review",
        labelText: "Write a review",
      ),
    );
  }

  Widget _buildSelectStarsDropDown() {
    return DropdownButton(
      hint: Text("Stars"),
      elevation: 0,
      value: this._selectedStar,
      items: this._stars.map((star) {
        return DropdownMenuItem<int>(
          child: Text(star.toString()),
          value: star,
        );
      }).toList(),
      onChanged: (item) {
        setState(() => this._selectedStar = item);
      },
    );
  }

  Widget _buildButton() {
    return Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.done),
          onPressed: () {
            if (this._selectedStar == null) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("You can't add a review without star"),
                duration: Duration(milliseconds: 500),
              ));
            } else if (this._commentController.text.isEmpty) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("Review comment cannot be empty"),
                duration: Duration(milliseconds: 500),
              ));
            } else {
              final newReview = ReviewModel(
                comment: _commentController.text,
                stars: _selectedStar,
              );

              this.reviewStore.addReview(newReview);
            }
          },
        );
      },
    );
  }

  Widget _buildReviewInfoCard() {
    return InfoCard(
      infoValue: this.reviewStore.numberOfReviews.toString(),
      infoLabel: "reviews",
      cardColor: Colors.green,
      iconData: Icons.comment,
    );
  }

  Widget _buildAverageStarsInfoCard() {
    return InfoCard(
      infoValue: this.reviewStore.averageStars.toStringAsFixed(2),
      infoLabel: "average stars",
      cardColor: Colors.lightBlue,
      iconData: Icons.star,
      key: Key('avgStar'),
    );
  }

  Widget _buildReviewMenu() {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.comment),
          SizedBox(width: 10.0),
          Text(
            "Reviews",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList() {
    return Expanded(
      child: Observer(builder: (context) {
        print('_buildReviewList');
        if (this.reviewStore.haveReviews) {
          return ListView.builder(
            itemCount: this.reviewStore.reviews.length,
            itemBuilder: (_, index) {
              final reviewItem = this.reviewStore.reviews[index];
              return ReviewItem(reviewItem: reviewItem);
            },
          );
        } else {
          return Text("No reviews yet");
        }
      }),
    );
  }
}
