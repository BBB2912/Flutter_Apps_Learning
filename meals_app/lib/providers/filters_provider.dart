import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersProviderNotifier extends StateNotifier<Map<Filter,bool>> {
  FiltersProviderNotifier():super({
    Filter.glutenFree:false,
    Filter.lactoseFree:false,
    Filter.vegan:false,
    Filter.vegetarian:false
  });

  
  setFilter(Filter filter, bool isActive){
    state={...state,filter:isActive};
  }
}
final filtersProvider=StateNotifierProvider<FiltersProviderNotifier,Map<Filter,bool>>((ref){
  return FiltersProviderNotifier();
});

final filterdMealsProvider=Provider((ref){
  final meals=ref.watch(mealsProvider);
  final filters=ref.watch(filtersProvider);
  return meals.where((meal){
      if(filters[Filter.glutenFree]!&&!meal.isGlutenFree){
        return false;
      }
      if(filters[Filter.lactoseFree]!&&!meal.isLactoseFree){
        return false;
      }
      if(filters[Filter.vegan]!&&!meal.isVegan){
        return false;
      }
      if(filters[Filter.vegetarian]!&&!meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
});