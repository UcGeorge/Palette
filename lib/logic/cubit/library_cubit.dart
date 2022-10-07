import 'package:coloors/logic/classes/library_palette.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';

part 'library_state.dart';

final _log = Logger('library_cubit');

class LibraryCubit extends HydratedCubit<LibraryState> {
  LibraryCubit() : super(LibraryState.init());

  @override
  void emit(LibraryState state) {
    _log.info(state);
    super.emit(state);
  }

  @override
  LibraryState? fromJson(Map<String, dynamic> json) =>
      LibraryState.fromMap(json);

  @override
  Map<String, dynamic>? toJson(LibraryState state) => state.toMap();

  void addToLibrary(LibraryPalette palette) =>
      emit(state.copyWith(library: state.library..add(palette)));

  void updatePalette(LibraryPalette palette) {
    final index = state.library.indexOf(palette);
    if (index >= 0) {
      emit(state.copyWith(
          library: state.library
            ..removeAt(index)
            ..insert(index, palette)));
    }
  }

  void removeFromLibrary(LibraryPalette palette) =>
      emit(state.copyWith(library: state.library..remove(palette)));
}
