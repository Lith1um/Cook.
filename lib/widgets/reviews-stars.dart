// Libs
import 'package:flutter/material.dart';

class ReviewStars extends StatelessWidget {
  final int reviews;
  final double score;
  final double size;

  const ReviewStars({
    @required this.reviews,
    @required this.score,
    this.size = 16.0
  });

  List<Widget> getStars() {
    int rounded = score.round();

    List<Widget> stars = [];

    for (int i = 0; i < 5; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: i+1 <= rounded ? Colors.amber : Colors.grey,
          size: size + 4.0,
        ),
      );
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...getStars(),
        Text(
          ' ($reviews)',
          style: TextStyle(
            color: Colors.grey,
            fontSize: size
          ),
        )
      ]
    );
  }
}
