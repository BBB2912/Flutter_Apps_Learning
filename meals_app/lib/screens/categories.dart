import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreen();
}

class _CategoriesScreen extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
    );
    _animationController.forward();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = ref.watch(filterdMealsProvider);
    final List<Meal> categoryMeals = filteredMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MealsScreen(title: category.title, meals: categoryMeals),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          ...availableCategories.map((category) {
            return CategoryGridItem(
              categoryItem: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            );
          }),
        ],
      ),
      builder: (context, child) {
        return SlideTransition(
          position:
              Tween(
                begin: const Offset(0.0, 0.3),
                end: const Offset(0.0, 0.0),
              ).animate(
                CurvedAnimation(
                  parent: _animationController,
                  curve: Curves.easeInOut,
                ),
              ),
              child: child,
        );
      },
    );
  }
}
