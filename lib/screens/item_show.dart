import 'package:flutter/material.dart';
import 'package:inventory_mobile/widgets/left_drawer.dart';

class ItemListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> itemList;

  ItemListWidget({required this.itemList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemList.length + 1, // Add 1 for the drawer
      itemBuilder: (context, index) {
        if (index == 0) {
          // This is where the drawer goes
          return const LeftDrawer();
        } else {
          // Display the list items
          final itemIndex = index - 1; // Adjust index for the actual list
          return ListTile(
            title: Text('Nama: ${itemList[itemIndex]['Nama']}'),
            subtitle: Text('Amount: ${itemList[itemIndex]['Amount']}\n'
                          'Description: ${itemList[itemIndex]['Deskripsi']}'),
            
            // Add more fields as needed
          );
        }
      },
    );
  }
}



