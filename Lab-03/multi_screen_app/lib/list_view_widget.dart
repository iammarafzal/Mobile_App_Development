import 'package:flutter/material.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> items = List<String>.generate(50, (index) => "Item ${index+1}");
    return Scaffold(
      appBar: AppBar(
        title: Text(("List View")),

      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Expanded(child: 
            ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  child: ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text("Item# ${items[index]}"),
                    subtitle: Text("This is item ${items[index]}"),
                    trailing: Icon(Icons.remove),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("The ${items[index]}"))
                      );
                    },
                  ),
                );
              }
              )
            ),
              ElevatedButton
              (onPressed: (){
                Navigator.pushNamed(context, '/grid-view');
              },
              child: Text("Grid View Widget"))
          ],
        ),
      ),
    );
  }
}