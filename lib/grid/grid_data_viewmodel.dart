import 'dart:math';

import 'package:flutter/material.dart';

class GridDataViewModel {
  static TextEditingController gridDataTextEditingController =
      TextEditingController();

  String validateGridData(String? value, int? length) {
    String pattern = r"[A-Za-z]+$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Enter Alphabets only without space';
    } else if (gridDataTextEditingController.text.length > length!) {
      return "Character length exceed";
    } else {
      return "";
    }
  }

  void generateRandomString(int? length) {
    String alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    Random random = Random();

    GridDataViewModel.gridDataTextEditingController.text = String.fromCharCodes(
      Iterable.generate(
        length!,
        (_) => alphabets.codeUnitAt(
          random.nextInt(alphabets.length),
        ),
      ),
    );
    GridDataViewModel.gridDataTextEditingController.selection =
        TextSelection.fromPosition(
      TextPosition(
        offset: GridDataViewModel.gridDataTextEditingController.text.length,
       ),
    );
  }
}

class CreateGrid {
  int? row;
  int? column;
  String? characterList;
  static List<List<String>> grid = [];

  CreateGrid.fill({this.row, this.column, this.characterList}) {
    int currentIndex = 0;
    for (int i = 0; i < row!; i++) {
      List<String> rowData = []; // Temporary variable to store row data

      for (int j = 0; j < column!; j++) {
        rowData.add(characterList![currentIndex]);
        currentIndex++;
      }
      grid.add(rowData);
    }
  }
}
