import 'package:flutter/material.dart';
import 'package:grociries/Widgets/new_Item.dart';
import 'package:grociries/data/dummy_items.dart';



class Grocerieslist extends StatefulWidget {
  const Grocerieslist({super.key});

  @override
  State<Grocerieslist> createState() => _GrocerieslistState();
}

class _GrocerieslistState extends State<Grocerieslist> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(
            groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
