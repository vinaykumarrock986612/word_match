import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:word_game/grid/grid_entry.dart';
import 'package:word_game/grid/grid_entry_viewmodel.dart';
import 'package:word_game/grid/grid_viewmodel.dart';

import 'grid_data_viewmodel.dart';

class Grid extends StatefulWidget {
  int? row;
  int? column;

  Grid({this.row, this.column});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  GridViewModel model = GridViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              GridViewModel.gridSearchController = TextEditingController();
              GridDataViewModel.gridDataTextEditingController = TextEditingController();
              GridEntryViewModel.rowCountController = TextEditingController();
              GridEntryViewModel.columnCountController = TextEditingController();
              CreateGrid.grid = [];
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GridEntry(),
                  ),
                  (route) => false);
            },
            icon: Icon(Icons.refresh, color: Colors.black, size: 35),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            controller: GridViewModel.gridSearchController,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            keyboardType: TextInputType.name,
            onChanged: (value) async {
              setState(() {});
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
            decoration: InputDecoration(
                label: Center(
                  child: Text(
                    "Enter 4 characters",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
                border: InputBorder.none),
          ),
          Center(
            child: ListView.builder(
              itemCount: widget.row,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, rowIndex) {
                return Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: widget.column,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, columnIndex) {
                        bool itemExist = model.checkItemExist(
                            item: CreateGrid.grid[rowIndex][columnIndex],
                            rowIndex: rowIndex,
                            columnIndex: columnIndex);
                        bool horizontalMatch = model.horizontalMatch(
                            rowIndex: rowIndex, columnIndex: columnIndex);
                        bool verticalMatch = model.verticalMatch(
                            rowIndex: rowIndex, columnIndex: columnIndex);

                        return Card(
                          child: Container(
                            width: 40,
                            alignment: Alignment.center,
                            color: horizontalMatch
                                ? Colors.greenAccent
                                : verticalMatch
                                    ? Colors.greenAccent
                                    : itemExist
                                        ? Colors.orangeAccent
                                        : Colors.white,
                            child: Text(
                              "${CreateGrid.grid[rowIndex][columnIndex]}",
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
