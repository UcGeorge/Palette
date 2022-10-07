import 'package:flutter/material.dart';

import '../../views/widgets/palette_page/alert_dialogue.dart';

class AlertService {
  static showAppDialogue(
    BuildContext context, {
    required String text,
    Duration? duration,
  }) =>
      showDialog(
        context: context,
        builder: (dialogueContext) {
          Future.delayed(
            duration ?? const Duration(seconds: 1),
            Navigator.of(dialogueContext).pop,
          );
          return MyAlertDialogue(text: text);
        },
      );
}
