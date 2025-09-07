import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key,required this.onSelectedMenuItem});
  final void Function(String identifier) onSelectedMenuItem;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.all(20),

            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.onSecondary,
                ],
                begin: Alignment.topLeft,
                end:Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.fastfood, size: 30),
                const SizedBox(width: 5),
                Text(
                  'Cooking Up!',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () {
              onSelectedMenuItem('Meals');
            },
            leading: Icon(Icons.local_dining_outlined,size: 24,),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(height: 5),
          ListTile(
            onTap: () {
              onSelectedMenuItem('Filters');
            },
            leading: Icon(Icons.settings, size: 24),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
