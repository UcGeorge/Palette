import 'package:coloors/logic/services/alert_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../logic/classes/color_tile.dart';
import '../../../logic/cubit/settings_cubit.dart';
import '../../../settings/theme.dart';

class ColorDataText extends StatelessWidget {
  const ColorDataText({
    Key? key,
    required this.colorTile,
    required this.colorInfo,
    required this.title,
  }) : super(key: key);

  final ColorInfo colorInfo;
  final ColorTile colorTile;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(
          text: colorTile.colorText(colorInfo).toUpperCase(),
        ));
        AlertService.showAppDialogue(
          context,
          text: 'Color copied!',
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextTheme.nunito.copyWith(
                color: colorTile.foregroundTextColor.withOpacity(.5),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            Text(
              colorTile.colorText(colorInfo).toUpperCase(),
              style: AppTextTheme.nunito.copyWith(
                color: colorTile.foregroundTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
