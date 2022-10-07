import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../views/widgets/library_page/add_palette.dart';
import '../classes/library_palette.dart';
import '../cubit/generator_cubit.dart';
import '../cubit/library_cubit.dart';

class LibraryService {
  static addPalette(
    BuildContext context, {
    LibraryPalette? libraryPalette,
    VoidCallback? onSuccess,
  }) async {
    LibraryPalette? palette = await showModalBottomSheet<LibraryPalette>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (modalContext) => AddPalette(
        palette: libraryPalette?.palette ??
            context.read<GeneratorCubit>().state.palette,
        name: libraryPalette != null ? '${libraryPalette.name} - Copy' : null,
        description: libraryPalette?.description,
        tags: libraryPalette?.tags,
        onSuccess: onSuccess,
      ),
    );
    if (palette != null) context.read<LibraryCubit>().addToLibrary(palette);
  }

  static updatePalette(
    BuildContext context, {
    required LibraryPalette libraryPalette,
    VoidCallback? onSuccess,
  }) async {
    LibraryPalette? palette = await showModalBottomSheet<LibraryPalette>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (modalContext) => AddPalette(
        palette: libraryPalette.palette,
        name: libraryPalette.name,
        description: libraryPalette.description,
        tags: libraryPalette.tags,
        onSuccess: onSuccess,
      ),
    );
    if (palette != null) {
      context
          .read<LibraryCubit>()
          .updatePalette(palette.copyWith(id: libraryPalette.id));
    }
  }
}
