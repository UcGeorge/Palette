import 'package:flutter/material.dart';

import '../../../settings/theme.dart';

class MyAlertDialogue extends StatelessWidget {
  const MyAlertDialogue({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            text,
            style: AppTextTheme.nunito.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              letterSpacing: .5,
            ),
          ),
        ),
      ),
    );
  }
}
