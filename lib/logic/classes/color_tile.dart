import 'dart:convert';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../cubit/settings_cubit.dart';

class ColorTile extends Equatable {
  const ColorTile(this.color, this.locked);

  factory ColorTile.fromJson(String source) =>
      ColorTile.fromMap(json.decode(source));

  factory ColorTile.fromMap(Map<String, dynamic> map) {
    return ColorTile(
      Color(map['color']),
      map['locked'] ?? false,
    );
  }

  final Color color;
  final bool locked;

  @override
  List<Object> get props => [color.value];

  @override
  String toString() => '#$colorTextHEX';

  ColorTile copyWith({
    Color? color,
    bool? locked,
  }) {
    return ColorTile(
      color ?? this.color,
      locked ?? this.locked,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'locked': locked,
    };
  }

  String toJson() => json.encode(toMap());

  String colorText(ColorInfo colorInfo) {
    switch (colorInfo) {
      case ColorInfo.none:
        return '';
      case ColorInfo.hex:
        return colorTextHEX;
      case ColorInfo.rgb:
        return colorTextRGB;
      case ColorInfo.hsb:
        return colorTextHSB;
      case ColorInfo.cmyk:
        return colorTextCMYK;
      case ColorInfo.lab:
        return colorTextLAB;
      case ColorInfo.hsl:
        return colorTextHSL;
    }
  }

  Color get foregroundTextColor =>
      (color.red * 0.299 + color.green * 0.587 + color.blue * 0.114) > 186
          ? Colors.black
          : Colors.white;

  String get colorTextHEX =>
      '${color.red.toRadixString(16).padLeft(2, '0')}${color.green.toRadixString(16).padLeft(2, '0')}${color.blue.toRadixString(16).padLeft(2, '0')}';

  String get colorTextRGB =>
      '${color.red.toString().padLeft(3, '0')}, ${color.green.toString().padLeft(3, '0')}, ${color.blue.toString().padLeft(3, '0')}';

  String get colorTextCMYK {
    final r_ = color.red / 255;
    final g_ = color.green / 255;
    final b_ = color.blue / 255;

    final k = [1 - r_, 1 - g_, 1 - b_].reduce(min);
    final c = (1 - r_ - k) / (1 - k);
    final m = (1 - g_ - k) / (1 - k);
    final y = (1 - b_ - k) / (1 - k);

    return '${(c * 100).round()}, ${(m * 100).round()}, ${(y * 100).round()}, ${(k * 100).round()}';
  }

  String get colorTextHSB {
    final r = color.red / 255;
    final g = color.green / 255;
    final b = color.blue / 255;

    final v = [r, g, b].reduce(max);
    final n = v - [r, g, b].reduce(min);
    final h = n == 0
        ? 0
        : (n > 0) && v == r
            ? (g - b) / n
            : v == g
                ? 2 + (b - r) / n
                : 4 + (r - g) / n;

    return "${(60 * (h < 0 ? h + 6 : h)).round()}, ${((v > 0) ? (n / v) * 100 : 0).round()}, ${(v * 100).round()}";
  }

  String get colorTextHSL {
    final r = color.red / 255;
    final g = color.green / 255;
    final b = color.blue / 255;

    final l = [r, g, b].reduce(max);
    final s = l - [r, g, b].reduce(min);
    final h = s > 0
        ? l == r
            ? (g - b) / s
            : l == g
                ? 2 + (b - r) / s
                : 4 + (r - g) / s
        : 0;

    return "${(60 * h < 0 ? 60 * h + 360 : 60 * h).round()}, ${(100 * (s > 0 ? (l <= 0.5 ? s / (2 * l - s) : s / (2 - (2 * l - s))) : 0)).round()}, ${((100 * (2 * l - s)) / 2).round()}";
  }

  String get colorTextLAB {
    //TODO: This function result is INCORRECT!
    int n = 0;
    final RGB = [0.0, 0.0, 0.0];

    for (int value_ in [color.red, color.green, color.blue]) {
      double value = value_ / 255;

      if (value > 0.04045) {
        value = pow((value + 0.055) / 1.055, 2.4).toDouble();
      } else {
        value = value / 12.92;
      }

      RGB[n] = value * 100;
      n++;
    }

    final XYZ = [0.0, 0.0, 0.0];

    final X = RGB[0] * 0.4124 + RGB[1] * 0.3576 + RGB[2] * 0.1805;
    final Y = RGB[0] * 0.2126 + RGB[1] * 0.7152 + RGB[2] * 0.0722;
    final Z = RGB[0] * 0.0193 + RGB[1] * 0.1192 + RGB[2] * 0.9505;
    XYZ[0] = double.parse(X.toStringAsFixed(4));
    XYZ[1] = double.parse(Y.toStringAsFixed(4));
    XYZ[2] = double.parse(Z.toStringAsFixed(4));

    n = 0;
    for (double value in XYZ) {
      if (value > 0.008856) {
        value = pow(value, 0.3333333333333333).toDouble();
      } else {
        value = (7.787 * value) + (16 / 116);
      }

      XYZ[n] = value;
      n++;
    }

    final LAB = [0.0, 0.0, 0.0];

    final L = (116 * XYZ[1]) - 16;
    final a = 500 * (XYZ[0] - XYZ[1]);
    final b = 200 * (XYZ[1] - XYZ[2]);

    LAB[0] = double.parse(L.toStringAsFixed(4));
    LAB[1] = double.parse(a.toStringAsFixed(4));
    LAB[2] = double.parse(b.toStringAsFixed(4));

    return "${LAB[0].round()}, ${LAB[1].round()}, ${LAB[2].round()}";
  }
}
