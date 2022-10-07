import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

import '../classes/color_tile.dart';
import '../classes/palette.dart';
import '../services/generator.dart';
import 'settings_cubit.dart';

part 'generator_state.dart';

final _log = Logger('generator_cubit');

class GeneratorCubit extends HydratedCubit<GeneratorState> {
  GeneratorCubit() : super(GeneratorState.init());

  @override
  void emit(GeneratorState state) {
    // _log.info(state);
    super.emit(state);
  }

  @override
  GeneratorState? fromJson(Map<String, dynamic> json) =>
      GeneratorState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(GeneratorState state) => state.toMap();

  void generatePalette([GenerateMethod? method]) {
    emit(state.copyWith(
      palette: GeneratorService.generatePalette(state.palette, method),
    ));
  }

  void loadPalette(Palette palette) {
    emit(state.copyWith(palette: palette));
  }

  void lockTile(ColorTile colorTile) {
    final index = state.palette.indexWhere((element) => element == colorTile);
    emit(state.copyWith(
        palette: state.palette
          ..removeAt(index)
          ..insert(
            index,
            colorTile.copyWith(
              locked: !colorTile.locked,
            ),
          )));
  }

  void reorderPalette(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    final tile = state.palette[oldIndex];
    emit(state.copyWith(
        palette: state.palette
          ..removeAt(oldIndex)
          ..insert(newIndex, tile)));
  }
}
