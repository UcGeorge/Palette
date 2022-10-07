import '../cubit/settings_cubit.dart';

const Map<String, AppTheme> appThemeFromMap = {
  'light': AppTheme.light,
  'dark': AppTheme.dark,
};

const Map<String, GenerateMethod> generateMethodFromMap = {
  'auto': GenerateMethod.auto,
  'monochromatic': GenerateMethod.monochromatic,
  'analogous': GenerateMethod.analogous,
  'complementary': GenerateMethod.complementary,
  'splitComplementary': GenerateMethod.splitComplementary,
  'triadic': GenerateMethod.triadic,
  'tetriadic': GenerateMethod.tetriadic,
  'square': GenerateMethod.square,
};

const Map<String, PalletteAction> palletteActionFromMap = {
  'viewPalette': PalletteAction.viewPalette,
  'openInGenerator': PalletteAction.openInGenerator,
};

const Map<String, ColorInfo> colorInfoFromMap = {
  'none': ColorInfo.none,
  'hex': ColorInfo.hex,
  'rgb': ColorInfo.rgb,
  'hsb': ColorInfo.hsb,
  'cmyk': ColorInfo.cmyk,
  'lab': ColorInfo.lab,
  'hsl': ColorInfo.hsl,
};

extension SerialAppTheme on AppTheme {
  String toMap() => toString().split('.').last;
}

extension SerialGenerateMethod on GenerateMethod {
  String toMap() => toString().split('.').last;
}

extension SerialPalletteAction on PalletteAction {
  String toMap() => toString().split('.').last;
}

extension SerialColorInfo on ColorInfo {
  String toMap() => toString().split('.').last;
}
