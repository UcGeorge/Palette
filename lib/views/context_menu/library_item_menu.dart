import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/classes/library_palette.dart';
import '../../logic/classes/menu_item.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/cubit/library_cubit.dart';
import '../../logic/services/library.dart';
import '../../logic/services/menu.dart';
import '../widgets/menu.dart';
import 'export_menu.dart';

class LibraryItemMenu extends MenuWidget {
  const LibraryItemMenu({
    super.key,
    required this.libraryPalette,
    required super.settingsState,
    required super.appContext,
  });

  final LibraryPalette libraryPalette;

  @override
  List<AppMenuItem> menu(BuildContext menuContext) => [
        AppMenuItem(
          icon: Icons.auto_fix_high_outlined,
          onTap: () {
            appContext
                .read<GeneratorCubit>()
                .loadPalette(libraryPalette.palette);
            Navigator.of(menuContext).pop();
            Navigator.of(appContext).pop();
          },
          title: 'Open in the generator',
        ),
        AppMenuItem(
          icon: Icons.share_outlined,
          onTap: () {
            Navigator.pop(menuContext);
            MenuService.showMenu(
              appContext,
              menuWidget: ExportMenu(
                appContext: appContext,
                settingsState: settingsState,
                palette: appContext.read<GeneratorCubit>().state.palette,
              ),
            );
          },
          title: 'Export palette',
          hasSubMenu: true,
        ),
        AppMenuItem(
          icon: Icons.copy_rounded,
          onTap: () {
            Navigator.pop(menuContext);
            LibraryService.addPalette(
              appContext,
              libraryPalette: libraryPalette,
            );
          },
          title: 'Duplicate palette',
        ),
        AppMenuItem(
          icon: Icons.edit_outlined,
          onTap: () {
            Navigator.pop(menuContext);
            LibraryService.updatePalette(
              appContext,
              libraryPalette: libraryPalette,
            );
          },
          title: 'Edit palette',
        ),
        AppMenuItem(
          icon: Icons.delete_outline_rounded,
          onTap: () {
            appContext.read<LibraryCubit>().removeFromLibrary(libraryPalette);
            Navigator.pop(menuContext);
          },
          title: 'Delete palette',
        ),
      ];
}
