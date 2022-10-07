import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/cubit/settings_cubit.dart';

class AppColors {
  AppColors({
    required this.subMenuColor,
    required this.white,
    required this.offWhite,
    required this.lightText,
    required this.darkText,
    required this.dividerColor,
    required this.switchDisabled,
  });

  final Color darkText;
  final Color dividerColor;
  final Color lightText;
  final Color offWhite;
  final Color switchDisabled;
  final Color white;
  final Color subMenuColor;
}

final Map<AppTheme, AppColors> theme = {
  AppTheme.light: AppColors(
    white: Colors.white,
    subMenuColor: Colors.white,
    offWhite: const Color(0xffF2F2F2),
    lightText: const Color(0xff807F84),
    darkText: const Color(0xff292929),
    dividerColor: const Color(0xffEEEEEE),
    switchDisabled: const Color(0xffE8E9EB),
  ),
  AppTheme.dark: AppColors(
    white: Colors.white,
    subMenuColor: Colors.white,
    offWhite: const Color(0xffF2F2F2),
    lightText: const Color(0xff807F84),
    darkText: const Color(0xff292929),
    dividerColor: const Color(0xffEEEEEE),
    switchDisabled: const Color(0xffE8E9EB),
  ),
};

class AppTextTheme {
  static TextStyle get nunito => GoogleFonts.nunito();
  static TextStyle get mono => GoogleFonts.notoSansMono();
}
