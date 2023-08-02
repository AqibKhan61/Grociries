import 'package:grociries/data/categories.dart';
import 'package:grociries/models/category.dart';
import 'package:grociries/models/grocery_item.dart';




final groceryItems = [
  GroceryItem(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category:  categories [Categories.vegetables]!,
      ),
  GroceryItem(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[Categories.fruit]!),
  GroceryItem(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[Categories.meat]!),
];