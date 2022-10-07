import 'package:flutter/material.dart';

import '../../logic/cubit/settings_cubit.dart';
import '../../settings/theme.dart';

class MoreHoriz extends StatelessWidget {
  const MoreHoriz({
    Key? key,
    required this.settingsState,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;
  final SettingsState settingsState;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        height: 36,
        width: 36,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.filled(3, null).map((e) => Padding(
                    padding: const EdgeInsets.all(1.7),
                    child: CircleAvatar(
                      radius: 1.5,
                      backgroundColor: theme[settingsState.theme]!.darkText,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
