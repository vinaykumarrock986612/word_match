import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/grid/grid_entry_viewmodel.dart';

import 'grid_data.dart';

class GridEntry extends StatefulWidget {
  const GridEntry({Key? key}) : super(key: key);

  @override
  State<GridEntry> createState() => _GridEntryState();
}

class _GridEntryState extends State<GridEntry> {
  String rowCountError = "";
  String columnCountError = "";

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    GridEntryViewModel model = GridEntryViewModel();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row Count TextField
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  controller: GridEntryViewModel.rowCountController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      rowCountError = model.validateRowColumn(value);
                    });
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      label: Center(
                        child: Text(
                          "Row Count",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            // Row Count Error
            Container(
              child: Text(
                "$rowCountError",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // Column Count TextField
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TextFormField(
                  controller: GridEntryViewModel.columnCountController,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      columnCountError = model.validateRowColumn(value);
                    });
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                      label: Center(
                        child: Text(
                          "Column Count",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            // Column Count Error
            Container(
              child: Text(
                "$columnCountError",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // Submit
            Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  if (GridEntryViewModel.rowCountController.text != "" &&
                      GridEntryViewModel.columnCountController.text != "" &&
                      rowCountError == "" &&
                      columnCountError == "") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridData(
                          row: int.parse(
                              GridEntryViewModel.rowCountController.text),
                          column: int.parse(
                              GridEntryViewModel.columnCountController.text),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 80,
                  width: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: themeData.colorScheme.primary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "NEXT",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
