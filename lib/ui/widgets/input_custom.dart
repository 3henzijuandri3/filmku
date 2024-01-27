import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class SearchBarCustom extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;

  const SearchBarCustom({super.key, required this.hintText, required this.controller, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,

      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,

        prefixIcon: Icon(Icons.search, color: greyColor, size: 20),

        hintStyle: greyTextStyle.copyWith(
            fontSize: 14,
            fontWeight: regular
        ),

        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)
        ),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(color: purpleColor)
        ),
      ),
    );
  }
}


class FilledInputCustom extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? inputType;

  const FilledInputCustom({super.key, this.hintText, required this.obscureText, this.controller, this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: inputType,

      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,

          hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular
          ),

          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50)
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: greenColor)
          ),
      ),
    );
  }
}