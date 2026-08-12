import 'package:remotely/core/utils/assets_manager/assets_manager.dart';
import 'package:remotely/core/widgets/custom_image.dart';
import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  final int maxRating; // Maximum number of stars
  final Function(int) onRatingSelected; // Callback for when a rating is selected

  const CustomRatingBar({super.key, this.maxRating = 5, required this.onRatingSelected});

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  int currentRating = 0;

  final List<String> starImages = [
    CustomAssetsManager.star0, // Default empty star
    CustomAssetsManager.star1, // 1-star image
    CustomAssetsManager.star2, // 2-star image
    CustomAssetsManager.star3, // 3-star image
    CustomAssetsManager.star4, // 4-star image
    CustomAssetsManager.star5, // 5-star image
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.maxRating, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentRating = index; // Set the current rating
            });
            widget.onRatingSelected(currentRating);
          },
          child: CustomImage(
            width: 40, // Adjust the size as needed
            height: 40,
            imagePath: index == currentRating
                ? starImages[currentRating + 1] // Use the current rating image
                : currentRating == 0
                ? starImages[0]
                : index > currentRating
                ? starImages[0]
                : CustomAssetsManager.star,
          ),
        );
      }),
    );
  }
}
