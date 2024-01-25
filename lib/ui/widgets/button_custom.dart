import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FilledButtonCustom extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final bool? isNeon;
  final Function onTap;

  const FilledButtonCustom({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.onTap,
    this.isNeon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          if(isNeon == true)
            BoxShadow(
                color: purpleColor.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 4)
            ),
        ],
      ),

      child: TextButton(
        onPressed: () => onTap(),

        style: TextButton.styleFrom(
          backgroundColor: purpleColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56)
          ),
        ),

        child: Text(
          label,
          style: whiteTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold
          ),
        ),
      ),
    );
  }
}

class MenuButtonCustom extends StatelessWidget {
  final String menuTitle;
  final IconData menuIcon;
  final bool isSelected;

  const MenuButtonCustom({
    super.key,
    required this.menuTitle,
    required this.menuIcon,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 110,

      decoration: BoxDecoration(
        color: isSelected ? purpleColor : whiteColor,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(8),

            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
            ),

            child: Icon(menuIcon, color: purpleColor, size: 26),
          ),

          const SizedBox(height: 10),

          Text(
            menuTitle,
            style: (isSelected
                ? whiteTextStyle
                : blackTextStyle)
                .copyWith(
              fontSize: 14,
              fontWeight: semiBold
            ),
          ),
        ],
      ),
    );
  }
}
