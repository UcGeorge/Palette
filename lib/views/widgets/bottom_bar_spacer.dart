import 'package:flutter/material.dart';

import '../../logic/util/general.dart';

class BorromBarSpacer extends StatelessWidget {
  const BorromBarSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenViewPadding(context).bottom,
    );
  }
}
