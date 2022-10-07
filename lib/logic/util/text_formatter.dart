import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 1 && newValue.text.startsWith('0')) {
      newText.write(newValue.text.substring(1));
      if (newValue.selection.end >= 1) selectionIndex--;
    } else {
      newText.write(newValue.text);
    }
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
