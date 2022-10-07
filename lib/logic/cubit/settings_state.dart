part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.colorInfo,
    required this.isolateColors,
    required this.palletteAction,
    required this.theme,
    required this.generateMethod,
  });

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source));

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      colorInfo: colorInfoFromMap[map['colorInfo']]!,
      generateMethod: generateMethodFromMap[map['generateMethod']]!,
      isolateColors: map['isolateColors'] ?? false,
      palletteAction: palletteActionFromMap[map['palletteAction']]!,
      theme: appThemeFromMap[map['theme']]!,
    );
  }

  factory SettingsState.init() => const SettingsState(
        colorInfo: ColorInfo.hex,
        generateMethod: GenerateMethod.auto,
        isolateColors: false,
        palletteAction: PalletteAction.viewPalette,
        theme: AppTheme.light,
      );

  final ColorInfo colorInfo;
  final GenerateMethod generateMethod;
  final bool isolateColors;
  final PalletteAction palletteAction;
  final AppTheme theme;

  @override
  List<Object> get props {
    return [
      colorInfo,
      generateMethod,
      isolateColors,
      palletteAction,
      theme,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'colorInfo': colorInfo.toMap(),
      'generateMethod': generateMethod.toMap(),
      'isolateColors': isolateColors,
      'palletteAction': palletteAction.toMap(),
      'theme': theme.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

enum AppTheme { light, dark }

enum PalletteAction { viewPalette, openInGenerator }

enum ColorInfo { none, hex, rgb, hsb, cmyk, lab, hsl }

enum GenerateMethod {
  auto,
  monochromatic,
  analogous,
  complementary,
  splitComplementary,
  triadic,
  tetriadic,
  square,
}
