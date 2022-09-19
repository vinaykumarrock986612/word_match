import 'package:flutter/material.dart';

class GridEntryViewModel {
  static TextEditingController rowCountController = TextEditingController();
  static TextEditingController columnCountController = TextEditingController();

  String validateRowColumn(String? value) {
    int? userEntry;
    try {
      userEntry = int.parse(value!);
      if (userEntry < 4 || userEntry > 8) {
        return "Enter numbers only between 4 to 8";
      }
    } catch (exception) {
      return "Enter numbers only";
    }
    return "";
  }
}
