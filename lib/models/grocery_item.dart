import 'package:grociries/models/category.dart';



class GroceryItem{
  GroceryItem({
    required this.id,
    required this.category,
    required this.name,
    required this.quantity,
});

  final String id;
  final String name;
  final int quantity;
  final  Ccategory category;
}


