import 'package:flutter/material.dart';

import '../../../logic/classes/color_tile.dart';
import '../../../settings/theme.dart';

class ColorTextField extends StatelessWidget {
  const ColorTextField({
    Key? key,
    required this.colorTile,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  final ColorTile colorTile;
  final TextEditingController controller;
  final ValueChanged<ColorTile> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autofocus: true,
              controller: controller,
              onChanged: (value) {
                final color =
                    Color(int.parse('0xFF${value.replaceAll('#', '')}'));
                onChanged(colorTile.copyWith(color: color));
              },
              style: AppTextTheme.nunito.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              decoration: InputDecoration(
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
          const SizedBox(width: 16),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: colorTile.color,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ],
      ),
    );
  }
}
