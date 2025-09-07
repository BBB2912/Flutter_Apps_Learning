import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorite_meal_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/side_menu.dart';


class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;



  
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _onSelectedMenuItem(String identifier)async{
    Navigator.of(context).pop();
    if(identifier=='Meals'){
      final avilableMeals=ref.read(mealsProvider);
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealsScreen(title: 'Meals',meals:avilableMeals)));
    }
    else if(identifier=='Filters'){
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>FiltersScreen()));
    

    }
  }

  @override
  Widget build(BuildContext context) {
    

    Widget activePage = CategoriesScreen();
    String activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favoriteMeals=ref.watch(favoriteMealProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Favorites';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer:SideMenu(onSelectedMenuItem: _onSelectedMenuItem,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
