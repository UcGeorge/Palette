import 'dart:math';

import 'package:flutter/material.dart';

import '../classes/color_tile.dart';
import '../classes/palette.dart';
import '../cubit/settings_cubit.dart';

class GeneratorService {
  static Palette generatePalette([
    Palette? colors_,
    GenerateMethod? method = GenerateMethod.auto,
  ]) {
    Palette colors = colors_?.map((e) => e).toList() ??
        [
          const ColorTile(Color(0xffF2F2F2), false),
          const ColorTile(Color(0xffF2F2F2), false),
          const ColorTile(Color(0xffF2F2F2), false),
          const ColorTile(Color(0xffF2F2F2), false),
          const ColorTile(Color(0xffF2F2F2), false),
        ];

    final random = Random(DateTime.now().millisecondsSinceEpoch);

    for (int i = 0; i < colors.length; i++) {
      if (!colors[i].locked) {
        final nextColor =
            Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
        colors[i] = ColorTile(nextColor, false);
      }
    }
    return colors;
  }
}
