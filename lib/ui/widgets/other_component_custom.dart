import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class movieInformation extends StatelessWidget {
  final IconData icon;
  final String label;

  const movieInformation({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Icon(icon, color: greyColor, size: 20),

        const SizedBox(width: 6),

        // Date
        Text(
          label,
          maxLines: 1,
          style: blackTextStyle.copyWith(
              fontSize: 13,
              fontWeight: medium
          ),
        )
      ],
    );
  }
}

class ratingInformation extends StatelessWidget {
  final String rating;
  final double xPadding;
  final double yPadding;
  final double fontSize;
  final double iconSize;

  const ratingInformation({
    super.key,
    required this.xPadding,
    required this.yPadding,
    required this.fontSize,
    required this.iconSize,
    required this.rating
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: xPadding, horizontal: yPadding),
        decoration: BoxDecoration(
          color: greyColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(15),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Star Icon
            const Icon(
              Icons.star,
              color: Colors.yellow,
              size: 18,
            ),

            const SizedBox(width: 4),

            // Movie Rate Score
            Text(
              rating,
              style: whiteTextStyle.copyWith(
                  fontSize: 13,
                  fontWeight: medium
              ),
            )
          ],
        ),
      ),
    );
  }
}
