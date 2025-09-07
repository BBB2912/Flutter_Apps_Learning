import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/providers/places_provider.dart';
import 'package:favorite_place_app/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesList extends ConsumerWidget {
  const PlacesList({super.key,required this.places});

  final List<Place> places;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    if (places.isEmpty) {
      return Center(
        child: Text(
          'No places right now add yet',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: ValueKey(places[index]),
          onDismissed: (direction) {
            ref
                .read(placesProvider.notifier)
                .removePlace(places[index]);
          },
          child: ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(places[index].image),
            ),
            title: Text(
              places[index].name,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 20,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailsScreen(place: places[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
