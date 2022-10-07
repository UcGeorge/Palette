import 'package:flutter/material.dart';

import '../../logic/classes/color_tile.dart';
import '../../settings/theme.dart';

class ColorBox extends StatelessWidget {
  const ColorBox(this.colorTile, {super.key});

  final ColorTile colorTile;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorTile.color,
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            colorTile.colorTextHEX.toUpperCase(),
            style: AppTextTheme.nunito.copyWith(
              color: colorTile.foregroundTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}
