import 'package:flutter/material.dart';
import 'package:grociries/Widgets/new_Item.dart';
import 'package:grociries/models/grocery_item.dart';

class Grocerieslist extends StatefulWidget {
  const Grocerieslist({super.key});

  @override
  State<Grocerieslist> createState() => _GrocerieslistState();
}

class _GrocerieslistState extends State<Grocerieslist> {
  final List<GroceryItem> _groceryItem = [];
  void _addItem() async {
    final newitem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );
    if (newitem == null) {
      return;
    }
    setState(() {
      _groceryItem.add(newitem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }

  @override
  Widget build(context) {
    Widget content = const Center(
      child: Text(
        'No Item is Added yet! Try to Add Some.',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItem[index]);
          },
          key: ValueKey(_groceryItem[index].id),
          child: ListTile(
            title: Text(_groceryItem[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItem[index].category.color,
            ),
            trailing: Text(
              _groceryItem[index].quantity.toString(),
            ),
          ),
        ),
      );
    }
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
      body: content,
    );
  }
}
