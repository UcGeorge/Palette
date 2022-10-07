import 'package:flutter/material.dart';

import '../../../logic/cubit/settings_cubit.dart';
import '../../../settings/theme.dart';

class UndoRedoIconButtons extends StatelessWidget {
  const UndoRedoIconButtons({
    Key? key,
    required this.canUndo,
    required this.canRedo,
    required this.settingsState,
    required this.undo,
    required this.redo,
  }) : super(key: key);

  final bool canRedo;
  final bool canUndo;
  final SettingsState settingsState;
  final VoidCallback undo;
  final VoidCallback redo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: undo,
          child: Container(
            height: 52,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.undo_rounded,
              size: 16,
              color: canUndo
                  ? theme[settingsState.theme]!.darkText
                  : theme[settingsState.theme]!.lightText.withOpacity(.7),
            ),
          ),
        ),
        GestureDetector(
          onTap: redo,
          child: Container(
            height: 52,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.redo_rounded,
              size: 16,
              color: canRedo
                  ? theme[settingsState.theme]!.darkText
                  : theme[settingsState.theme]!.lightText.withOpacity(.7),
            ),
          ),
        ),
      ],
    );
  }
}
