import 'package:flutter/material.dart';

import '../../../logic/cubit/settings_cubit.dart';
import '../../../settings/theme.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    Key? key,
    required this.settingsState,
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasSubMenu = false,
  }) : super(key: key);
  final SettingsState settingsState;
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasSubMenu;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 20,
        color: theme[settingsState.theme]!.darkText,
      ),
      title: Text(
        title,
        style: AppTextTheme.nunito.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16,
        ),
      ),
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 22),
      dense: true,
      trailing: hasSubMenu ? const Icon(Icons.chevron_right_rounded) : null,
    );
  }
}
