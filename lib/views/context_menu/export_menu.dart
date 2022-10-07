import 'package:flutter/material.dart';

import '../../logic/classes/menu_item.dart';
import '../../logic/classes/palette.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/export.dart';
import '../widgets/menu.dart';

class ExportMenu extends MenuWidget {
  const ExportMenu({
    super.key,
    required super.settingsState,
    required this.palette,
    required super.appContext,
  });

  final Palette palette;

  @override
  List<AppMenuItem> menu(menuContext) => [
        AppMenuItem(
          icon: Icons.link_rounded,
          onTap: () => ExportService.copyUrl(
            appContext,
            palette: palette,
            onSuccess: () {
              Navigator.of(menuContext).pop();
              AlertService.showAppDialogue(
                appContext,
                text: 'URL copied!',
              );
            },
          ),
          title: 'Copy URL',
        ),
        AppMenuItem(
          icon: Icons.picture_as_pdf_outlined,
          onTap: () => ExportService.pdf(
            appContext,
            palette: palette,
            onSuccess: Navigator.of(menuContext).pop,
          ),
          title: 'PDF',
        ),
        AppMenuItem(
          icon: Icons.image_outlined,
          onTap: () => ExportService.image(
            appContext,
            palette: palette,
            onSuccess: Navigator.of(menuContext).pop,
          ),
          title: 'Image',
        ),
        AppMenuItem(
          icon: Icons.draw_outlined,
          onTap: () => ExportService.svg(
            appContext,
            palette: palette,
            onSuccess: () {
              Navigator.of(menuContext).pop();
              AlertService.showAppDialogue(
                appContext,
                text: 'Coming soon!',
              );
            },
          ),
          title: 'SVG',
        ),
        AppMenuItem(
          icon: Icons.palette_outlined,
          onTap: () => ExportService.ase(
            appContext,
            palette: palette,
            onSuccess: () {
              Navigator.of(menuContext).pop();
              AlertService.showAppDialogue(
                appContext,
                text: 'Coming soon!',
              );
            },
          ),
          title: 'ASE',
        ),
      ];
}
