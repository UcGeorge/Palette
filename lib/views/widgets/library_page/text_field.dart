import 'package:flutter/material.dart';

import '../../../settings/theme.dart';

class SettingsTextField extends StatelessWidget {
  const SettingsTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.autoFocus = false,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            label,
            style: AppTextTheme.nunito.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: autoFocus,
              minLines: 1,
              maxLines: 5,
              onChanged: onChanged,
              style: AppTextTheme.nunito.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextTheme.nunito.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black.withOpacity(.3),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
