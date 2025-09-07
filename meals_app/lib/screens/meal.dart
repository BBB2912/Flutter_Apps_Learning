import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorite_meal_provider.dart';
import 'package:meals_app/widgets/meal_trait.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealProvider);

    final isMealFavorite = favoriteMeals.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              ref
                  .read(favoriteMealProvider.notifier)
                  .toggleMealFavoriteStatus(meal);
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                    key: ValueKey(isMealFavorite),
                    isMealFavorite ? Icons.star : Icons.star_border,
                    color: isMealFavorite ? Colors.red : null,
                  ),
            ),

          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 14),
              Text(
                meal.title,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              ...meal.ingredients.map((ingredient) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 14,
                  ),
                  child: Text(
                    '• $ingredient',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(
                    Icons.checklist_sharp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Steps',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5),
              ...meal.steps.map((step) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                    horizontal: 14,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_sharp),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          step,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MealTrait(
                      icon: meal.isGlutenFree ? Icons.check : Icons.close,
                      label: 'GlutenFree',
                    ),
                    SizedBox(width: 5),
                    MealTrait(
                      icon: meal.isLactoseFree ? Icons.check : Icons.close,
                      label: 'LactoseFree',
                    ),
                    SizedBox(width: 5),
                    MealTrait(
                      icon: meal.isVegan ? Icons.check : Icons.close,
                      label: 'LactoseFree',
                    ),
                    SizedBox(width: 5),
                    MealTrait(
                      icon: meal.isVegetarian ? Icons.check : Icons.close,
                      label: 'LactoseFree',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
