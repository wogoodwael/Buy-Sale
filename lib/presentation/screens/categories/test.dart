import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'Item 6', 'Item 7', 'Item 8'];

  @override
  Widget build(BuildContext context) {
    // Assuming you want to display 2 items in each row
    int itemsPerRow = 2;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sorted Data in Rows and Columns'),
        ),
        body: ListView.builder(
          itemCount: (items.length / itemsPerRow).ceil(),
          itemBuilder: (BuildContext context, int rowIndex) {
            int startIndex = rowIndex * itemsPerRow;
            int endIndex = (rowIndex + 1) * itemsPerRow;

            if (endIndex > items.length) {
              endIndex = items.length;
            }

            List<String> currentRowItems = items.sublist(startIndex, endIndex);

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  for (var item in currentRowItems)
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item, style: TextStyle(fontSize: 18.0)),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
