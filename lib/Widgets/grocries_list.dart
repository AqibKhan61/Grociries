import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grociries/data/categories.dart';
import 'package:grociries/Widgets/new_Item.dart';
import 'package:grociries/models/grocery_item.dart';

class Grocerieslist extends StatefulWidget {
  const Grocerieslist({super.key});

  @override
  State<Grocerieslist> createState() => _GrocerieslistState();
}

class _GrocerieslistState extends State<Grocerieslist> {
  List<GroceryItem> _groceryItem = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'flutter-1st-dc4b6-default-rtdb.firebaseio.com', 'Shoping-list.json');
    final response = await http.get(url);

    if (response.body == 'null'){
      setState(() {
        _isLoading = false;
      });
      return;
    }
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadeditem = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      loadeditem.add(
        GroceryItem(
          id: item.key,
          category: category,
          name: item.value['name'],
          quantity: item.value['quantity'],
        ),
      );
    }
    setState(() {
      _groceryItem = loadeditem;
      _isLoading = false;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: ((context) => const NewItem()),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    final url = Uri.https(
        'flutter-1st-dc4b6-default-rtdb.firebaseio.com', 'Shoping-list/${item.id}.json');
    http.delete(url);
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

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }
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
