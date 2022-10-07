import 'package:flutter/material.dart';

import '../../logic/classes/menu_item.dart';
import '../../logic/cubit/settings_cubit.dart';
import '../../settings/theme.dart';
import 'bottom_bar_spacer.dart';
import 'menu/manu_tile.dart';

abstract class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
    required this.settingsState,
    required this.appContext,
  });

  final BuildContext appContext;
  final SettingsState settingsState;

  List<AppMenuItem> menu(BuildContext menuContext);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 4),
        ...menu(context).map(
          (e) => Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MenuTile(
                settingsState: settingsState,
                icon: e.icon,
                onTap: e.onTap,
                title: e.title,
                hasSubMenu: e.hasSubMenu,
              ),
              const Divider(height: 8),
            ],
          ),
        ),
        GestureDetector(
          onTap: Navigator.of(context).pop,
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
  }
}
