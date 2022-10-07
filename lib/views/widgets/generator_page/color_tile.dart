import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../logic/classes/color_tile.dart';
import '../../../logic/cubit/generator_cubit.dart';
import '../../../logic/cubit/settings_cubit.dart';
import '../../../logic/util/general.dart';
import '../../../settings/theme.dart';

class ColorTileWidget extends StatelessWidget {
  const ColorTileWidget({
    Key? key,
    required this.colorTile,
    required this.settingsState,
  }) : super(key: key);

  final ColorTile colorTile;
  final SettingsState settingsState;

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = Get.statusBarHeight;

    return Container(
      color: colorTile.color,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      //TODO: Find a more stable way to get Status Bar Height
      height: (screenSize(context).height - statusBarHeight) / 5,
      child: Row(
        children: [
          Text(
            colorTile.colorText(settingsState.colorInfo).toUpperCase(),
            style: AppTextTheme.mono.copyWith(
              color: colorTile.foregroundTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 1.5,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => context.read<GeneratorCubit>().lockTile(colorTile),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(8),
              child: Icon(
                colorTile.locked ? Icons.lock_rounded : Icons.lock_open_rounded,
                color: colorTile.foregroundTextColor.withOpacity(.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
