import 'package:flutter/material.dart';

import '../../logic/classes/palette.dart';
import '../../logic/cubit/settings_cubit.dart';
import '../../logic/services/alert_dialogue.dart';
import '../../logic/services/export.dart';
import '../../settings/theme.dart';
import '../widgets/bottom_bar_spacer.dart';
import '../widgets/menu/manu_tile.dart';

Widget exportMenu(
  BuildContext context, {
  required SettingsState settingsState,
  required Palette palette,
}) {
  return Builder(
    builder: (menuContext) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 4),
          MenuTile(
            settingsState: settingsState,
            icon: Icons.link_rounded,
            onTap: () => ExportService.copyUrl(
              context,
              palette: palette,
              onSuccess: () {
                Navigator.of(menuContext).pop();
                AlertService.showAppDialogue(
                  context,
                  text: 'URL copied!',
                );
              },
            ),
            title: 'Copy URL',
          ),
          const Divider(height: 8),
          MenuTile(
            settingsState: settingsState,
            icon: Icons.picture_as_pdf_outlined,
            onTap: () => ExportService.pdf(
              context,
              palette: palette,
              onSuccess: Navigator.of(menuContext).pop,
            ),
            title: 'PDF',
          ),
          const Divider(height: 8),
          MenuTile(
            settingsState: settingsState,
            icon: Icons.image_outlined,
            onTap: () => ExportService.image(
              context,
              palette: palette,
              onSuccess: Navigator.of(menuContext).pop,
            ),
            title: 'Image',
          ),
          const Divider(height: 8),
          MenuTile(
            settingsState: settingsState,
            icon: Icons.draw_outlined,
            onTap: () => ExportService.svg(
              context,
              palette: palette,
              onSuccess: () {
                Navigator.of(menuContext).pop();
                AlertService.showAppDialogue(
                  context,
                  text: 'Coming soon!',
                );
              },
            ),
            title: 'SVG',
          ),
          const Divider(height: 8),
          MenuTile(
            settingsState: settingsState,
            icon: Icons.palette_outlined,
            onTap: () => ExportService.ase(
              context,
              palette: palette,
              onSuccess: () {
                Navigator.of(menuContext).pop();
                AlertService.showAppDialogue(
                  context,
                  text: 'Coming soon!',
                );
              },
            ),
            title: 'ASE',
          ),
          const Divider(height: 8),
          GestureDetector(
            onTap: Navigator.of(menuContext).pop,
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Cancel',
                  style: AppTextTheme.nunito.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          const BorromBarSpacer(),
        ],
      );
    },
  );
}
