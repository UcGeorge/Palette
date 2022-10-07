import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/classes/menu_item.dart';
import '../../logic/cubit/generator_cubit.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/library.dart';
import '../../logic/services/menu.dart';
import '../../logic/util/navigation.dart';
import '../pages/palette.dart';
import '../widgets/menu.dart';
import 'export_menu.dart';

class GeneratorMenu extends MenuWidget {
  const GeneratorMenu({
    super.key,
    required super.settingsState,
    required super.appContext,
  });

  @override
  List<AppMenuItem> menu(BuildContext menuContext) => [
        AppMenuItem(
          icon: Icons.remove_red_eye_outlined,
          onTap: () {
            Navigator.of(menuContext).pop();
            cupertinoPageNav(
              appContext,
              child: PaletteView(
                palette: appContext.read<GeneratorCubit>().state.palette,
              ),
            );
          },
          title: 'View palette',
        ),
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
                palette: appContext.read<GeneratorCubit>().state.palette,
              ),
            );
          },
          title: 'Export palette',
        ),
      ];
}
