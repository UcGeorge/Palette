import 'package:flutter/material.dart';

import '../../../logic/classes/library_palette.dart';
import '../../../logic/cubit/settings_cubit.dart';
import '../../../settings/theme.dart';
import '../more_horiz.dart';

class LibraryPaletteStrip extends StatelessWidget {
  const LibraryPaletteStrip({
    super.key,
    required this.libraryPalette,
    required this.settingsState,
    required this.onTap,
    required this.onMenuTap,
  });

  final LibraryPalette libraryPalette;
  final VoidCallback onTap;
  final VoidCallback onMenuTap;
  final SettingsState settingsState;

  SizedBox _buildColorStrip() {
    return SizedBox(
      height: 45,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: libraryPalette.palette
              .map((e) => Expanded(child: Container(color: e.color)))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorStrip(),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    libraryPalette.name,
                    style: AppTextTheme.nunito.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  MoreHoriz(settingsState: settingsState, onTap: onMenuTap)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
