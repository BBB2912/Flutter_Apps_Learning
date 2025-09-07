import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class ShoppingListItem extends StatelessWidget {
  const ShoppingListItem({super.key, required this.shoppingItem,required this.onRemove});

  final GroceryItem shoppingItem;
  final void Function(GroceryItem item) onRemove;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:ValueKey(shoppingItem),
      
      onDismissed: (direction) {
        onRemove(shoppingItem);
      },
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(3),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child:  Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: shoppingItem.category.color,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 3,
                  style: BorderStyle.solid
                ),
              ),
            ),
          ),
      
        title: Text(
          shoppingItem.name,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 20,
          ),
        ),
        trailing: Text(
          shoppingItem.quantity.toString(),
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
