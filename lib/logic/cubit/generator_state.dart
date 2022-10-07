part of 'generator_cubit.dart';

class GeneratorState extends Equatable {
  GeneratorState(this.palette) : dateModified = DateTime.now();

  factory GeneratorState.fromJson(String source) =>
      GeneratorState.fromMap(json.decode(source));

  factory GeneratorState.fromMap(Map<String, dynamic> map) {
    return GeneratorState(
      Palette.from(map['colors']?.map((x) => ColorTile.fromMap(x))),
    );
  }

  factory GeneratorState.init() =>
      GeneratorState(GeneratorService.generatePalette());

  final Palette palette;
  final DateTime dateModified;

  @override
  List<Object> get props => [dateModified];

  GeneratorState copyWith({
    Palette? palette,
  }) {
    return GeneratorState(
      palette ?? this.palette,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'colors': palette.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Palette: $palette';
}
