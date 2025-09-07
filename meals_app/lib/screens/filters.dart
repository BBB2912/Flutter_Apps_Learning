import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';


class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final activeFilters=ref.watch(filtersProvider);
    return PopScope<Map<Filter, bool>>(
      canPop: true, // we want to control popping
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return; // already popped, do nothing
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Filters')),
        body: Column(
          children: [
            SwitchListTile(
              value: activeFilters[Filter.glutenFree]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.glutenFree, isChecked);
              },
              title: Text(
                'Gluten Free',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Meals only GlutenFree ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: activeFilters[Filter.lactoseFree]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.lactoseFree, isChecked);
              },
              title: Text(
                'Lactose Free',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Meals only Lactose',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: activeFilters[Filter.vegan]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegan, isChecked);
              },
              title: Text(
                'Vegan Free',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Meals only Vegan ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(height: 10),
            SwitchListTile(
              value: activeFilters[Filter.vegetarian]!,
              onChanged: (isChecked) {
                ref.read(filtersProvider.notifier).setFilter(Filter.vegetarian, isChecked);
              },
              title: Text(
                'Vegetarian Free',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                'Meals only Vegetarian ',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
