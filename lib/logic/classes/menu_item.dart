import 'package:flutter/material.dart';

class AppMenuItem {
  final bool hasSubMenu;
  final IconData icon;
  final VoidCallback onTap;
  final String title;

  AppMenuItem({
    this.hasSubMenu = false,
    required this.icon,
    required this.onTap,
    required this.title,
  });
}
