import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> items = List.generate(50, (index) => {
      'id': index,
      'name': "Item # ${index + 1}",
      'color': Colors.deepPurple[(index % 9 + 1) * 100]
    });

    return Scaffold(
      appBar: AppBar(
        title: Text("Grid View"),

      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Expanded(child: 
              GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1
                ), 
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    color: items[index]['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  );
                })
              )
          ],
        ),
      ),
    );
  }
}