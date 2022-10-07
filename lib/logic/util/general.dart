import 'dart:math';

import 'package:flutter/cupertino.dart';

void doNothing() {}

Size screenSize(BuildContext context) => MediaQuery.of(context).size;
EdgeInsets screenViewPadding(BuildContext context) =>
    MediaQuery.of(context).viewPadding;
EdgeInsets screenViewInsets(BuildContext context) =>
    MediaQuery.of(context).viewInsets;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String get randomKey => generateKey(64, Random(DateTime.now().millisecond));
String generateKey(int length, Random _rnd) =>
    String.fromCharCodes(Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));

String capitalize(String input) =>
    input.split(' ').map((e) => e[0].toUpperCase() + e.substring(1)).join(' ');

String formatAmount(num amount) {
  String price = amount.toString();
  String priceInText = "";
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

Map<int, String> months = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: "May",
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December",
};

String dateFormat(DateTime dateTime) =>
    "${dateTime.day} ${months[dateTime.month]} ${dateTime.year}, ${dateTime.hour}:${dateTime.minute} GMT";
