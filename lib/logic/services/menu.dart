import 'package:flutter/material.dart';

import '../../views/widgets/menu.dart';

class MenuService {
  static void showMenu(
    BuildContext context, {
    required MenuWidget menuWidget,
  }) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (_) => menuWidget,
    );
  }
}
