import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories_data.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item_add.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/widgets/shopping_list_item.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreen();
}

class _ShoppingListScreen extends State<ShoppingListScreen> {
  List<GroceryItem> shoppingItemsList = [];
  Widget? content;
  var isLoading = false;
  var loadingMessage = '';
  var isError='';
  @override
  void initState() {
    super.initState();

    _loadItems();
  }

  void _loadItems() async {
    setState(() {
      isLoading = true;
      loadingMessage = 'Loading Shopping Items From FireBase';
    });
    final url = Uri.https(
      'shopping-list-app-4e351-default-rtdb.firebaseio.com',
      'shopping_list.json',
    );

    final response = await http.get(url);
    if (response.body == 'null') {
      setState(() {
        isLoading = false;
        loadingMessage = '';
      });
      return;
    }
    if(response.statusCode>=400){
      setState(() {
        isLoading=false;
        isError='Somehing went wrong please try after some time..';
      });
    }
    final Map<String, dynamic> rawData = json.decode(response.body);
    final List<GroceryItem> loadItems;
    loadItems = rawData.entries.map((item) {
      final category = categories.entries.firstWhere(
        (category) => category.value.categoryName == item.value['category'],
      );
      return GroceryItem(
        category: category.value,
        id: item.key,
        name: item.value['name'],
        quantity: int.parse(item.value['quantity']),
      );
    }).toList();

    setState(() {
      shoppingItemsList = loadItems;
      isLoading = false;
      loadingMessage = '';
    });
  }

  void _addItem() async {
    final groceryItem = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => NewItemAdd()));

    if (groceryItem == null) {
      return;
    }

    setState(() {
      shoppingItemsList.add(groceryItem);
    });
  }

  void _removeItem(GroceryItem item) async {
    final index=shoppingItemsList.indexOf(item);
    setState(() {
      isLoading = true;
      loadingMessage = 'Removing Item In FireBase';
    });
    shoppingItemsList.remove(item);
    final url = Uri.https(
      'shopping-list-app-4e351-default-rtdb.firebaseio.com',
      'shopping_list/${item.id}.json',
    );
    final response=await http.delete(url);

    if(response.statusCode>=400){
      setState(() {
        shoppingItemsList.insert(index, item);
      });
    }
    setState(() {
      isLoading = false;
      loadingMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              loadingMessage,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      );
    } else if (shoppingItemsList.isEmpty) {
      content = Center(
        child: Text(
          'No groceries Items is there add yet..',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: shoppingItemsList.length,
        itemBuilder: (context, index) {
          return ShoppingListItem(
            shoppingItem: shoppingItemsList[index],
            onRemove: _removeItem,
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('Shopping List')),
      body: content,
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        tooltip: 'Add Item',
        foregroundColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, size: 30),
      ),
    );
  }
}
