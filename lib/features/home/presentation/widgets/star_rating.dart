import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  final int rating;
  final int maxRating;

  final double starSize;
  final ValueChanged<int>? onRatingChanged;

  const StarRating({
    super.key,
    this.rating = 0,
    this.maxRating = 5,
    this.starSize = 24.0,
    this.onRatingChanged,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  Widget buildStar(BuildContext context, int index) {
    Widget icon;
    if (index < widget.rating) {
      icon = CustomImage(imagePath: CustomAssetsManager.starsRateFilled);
    } else {
      icon = CustomImage(imagePath: CustomAssetsManager.starsRateNon);
    }

    return GestureDetector(
      onTap: () {
        if (widget.onRatingChanged != null) {
          widget.onRatingChanged!(index + 1); // Set rating to star index + 1
        }
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) => buildStar(context, index)),
    );
  }
}
