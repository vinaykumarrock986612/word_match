import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/grid/grid.dart';
import 'package:word_game/grid/grid_data_viewmodel.dart';

class GridData extends StatefulWidget {
  int? gridLength;
  int? row;
  int? column;

  GridData({int? row, int? column}) {
    this.row = row;
    this.column = column;
    gridLength = row! * column!;
  }

  @override
  State<GridData> createState() => _GridDataState();
}

class _GridDataState extends State<GridData> {
  String error = "";
  GridDataViewModel model = GridDataViewModel();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Grid Data TextField
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    // TextField
                    Expanded(
                      child: TextFormField(
                        controller:
                            GridDataViewModel.gridDataTextEditingController,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          setState(() {
                            error = model.validateGridData(
                                value, widget.gridLength);
                          });
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(widget.gridLength),
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                        ],
                        decoration: InputDecoration(
                            label: Center(
                              child: Text(
                                "Enter ${widget.gridLength} characters",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${GridDataViewModel.gridDataTextEditingController.text.length}/${widget.gridLength}",
                      style: TextStyle(
                          color: GridDataViewModel.gridDataTextEditingController
                                      .text.length >
                                  widget.gridLength!
                              ? Colors.red
                              : Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            // Error
            Container(
              child: Text(
                "$error",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red),
              ),
            ),
            // AutoFill
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    model.generateRandomString(widget.gridLength);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "AUTO FILL",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            // Divider
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Divider(thickness: 2),
              ),
            ),
            // Submit
            Center(
              child: InkWell(
                onTap: () {
                  if (GridDataViewModel.gridDataTextEditingController.text !=
                          "" &&
                      error == "" &&
                      widget.gridLength ==
                          GridDataViewModel
                              .gridDataTextEditingController.text.length) {
                    CreateGrid.fill(
                        row: widget.row,
                        column: widget.column,
                        characterList: GridDataViewModel
                            .gridDataTextEditingController.text
                            .toUpperCase());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Grid(row: widget.row, column: widget.column),
                        ));
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
