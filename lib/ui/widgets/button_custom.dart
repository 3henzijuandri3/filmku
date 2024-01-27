import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class FilledButtonCustom extends StatelessWidget {
  final double width;
  final double height;
  final String label;
  final bool? isNeon;
  final Function onTap;
  final double? labelSize;
  final Color? color;

  const FilledButtonCustom({
    super.key,
    required this.width,
    required this.height,
    required this.label,
    required this.onTap,
    this.isNeon, this.labelSize, this.color
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
          backgroundColor: color ?? purpleColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56)
          ),
        ),

        child: Text(
          label,
          style: whiteTextStyle.copyWith(
              fontSize: labelSize ?? 16,
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
      width: 120,
      height: 120,

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
              color: isSelected ? whiteColor : purpleColor,
              shape: BoxShape.circle,
            ),

            child: Icon(menuIcon, color: isSelected ? purpleColor : whiteColor, size: 34),
          ),

          const SizedBox(height: 10),

          Text(
            menuTitle,
            style: (isSelected
                ? whiteTextStyle
                : blackTextStyle)
                .copyWith(
              fontSize: 16,
              fontWeight: semiBold
            ),
          ),
        ],
      ),
    );
  }
}
