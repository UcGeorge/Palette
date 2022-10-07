import 'package:flutter/material.dart';

import '../../logic/cubit/settings_cubit.dart';
import '../../settings/theme.dart';

class MenuVert extends StatelessWidget {
  const MenuVert({
    Key? key,
    required this.settingsState,
    required this.onTap,
  }) : super(key: key);

  final SettingsState settingsState;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        padding: const EdgeInsets.only(right: 4),
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.filled(3, null).map((e) => Padding(
                    padding: const EdgeInsets.all(1.8),
                    child: Container(
                      height: 1.8,
                      width: 15,
                      decoration: BoxDecoration(
                        color: theme[settingsState.theme]!.darkText,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
