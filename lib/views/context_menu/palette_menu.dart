import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/classes/menu_item.dart';
import '../../logic/classes/palette.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/library.dart';
import '../../logic/services/menu.dart';
import '../widgets/menu.dart';
import 'export_menu.dart';

class PaletteMenu extends MenuWidget {
  const PaletteMenu({
    super.key,
    required super.settingsState,
    required super.appContext,
    required this.palette,
    this.name,
    this.onPop,
  });

  final String? name;
  final VoidCallback? onPop;
  final Palette palette;

  @override
  List<AppMenuItem> menu(BuildContext menuContext) => [
        AppMenuItem(
          icon: Icons.auto_fix_high_outlined,
          onTap: () {
            appContext.read<GeneratorCubit>().loadPalette(palette);
            Navigator.of(menuContext).pop();
            Navigator.of(appContext).pop();
            onPop?.call();
          },
          title: 'Open in the generator',
        ),
        if (name == null)
          AppMenuItem(
            icon: Icons.favorite_border,
            onTap: () {
              Navigator.of(menuContext).pop();
              LibraryService.addPalette(
                appContext,
                onSuccess: () => AlertService.showAppDialogue(
                  appContext,
                  text: 'Palette saved!',
                ),
              );
            },
            title: 'Save palette',
          ),
        AppMenuItem(
          hasSubMenu: true,
          icon: Icons.share_outlined,
          onTap: () {
            Navigator.pop(menuContext);
            MenuService.showMenu(
              appContext,
              menuWidget: ExportMenu(
                appContext: appContext,
                settingsState: settingsState,
                palette: palette,
              ),
            );
          },
          title: 'Export palette',
        ),
      ];
}
