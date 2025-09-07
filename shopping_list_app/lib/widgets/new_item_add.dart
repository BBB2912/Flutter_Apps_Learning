import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class NewItemAdd extends StatefulWidget {
  const NewItemAdd({super.key});

  @override
  State<NewItemAdd> createState() => _NewItemAddState();
}

class _NewItemAddState extends State<NewItemAdd> {
  final _formKey = GlobalKey<FormState>();
  Category? _selectedCategory = categories[Categories.vegetables];
  String enteredName = '';
  int enteredQuantity = 1;
  var isSaving = false;

  void _saveItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSaving = true;
      });
      _formKey.currentState!.save();

      final groceryItem = {
        'name': enteredName,
        'quantity': enteredQuantity.toString(),
        'category': _selectedCategory!.categoryName,
      };
      final url = Uri.https(
        'shopping-list-app-4e351-default-rtdb.firebaseio.com',
        'shopping_list.json',
      );

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(groceryItem),
      );
      final Map<String,dynamic> resData=json.decode(response.body);

      if (!mounted) return;
      Navigator.of(context).pop(
        GroceryItem(
          category: _selectedCategory!,
          id: resData['name'],
          name: enteredName,
          quantity: enteredQuantity,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Item')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: enteredName,
                maxLength: 50,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter Item Name',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters.';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  enteredName = newValue!;
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      initialValue: enteredQuantity.toString(),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        hintText: 'Enter No.of Items',
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid, positive number.';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        enteredQuantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      initialValue: _selectedCategory,
                      items: categories.entries.map((category) {
                        return DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: category.value.color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                category.value.categoryName,
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: Text('Reset'),
                  ),
                  const SizedBox(width: 5),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Row(
                      children: [
                        Text(isSaving ? 'Saving' : 'Add Item'),
                        const SizedBox(width: 5),
                        if (isSaving)
                          const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white, // so it looks nice on button
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
