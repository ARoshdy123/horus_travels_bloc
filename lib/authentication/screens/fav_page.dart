import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/main_widgets/base_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Map<String, dynamic>> favoritePlaces = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? placesData = prefs.getString('places');
    if (placesData != null) {
      final List<Map<String, dynamic>> allPlaces =
          List<Map<String, dynamic>>.from(json.decode(placesData));

      setState(() {
        favoritePlaces =
            allPlaces.where((place) => place['isFavorite'] == true).toList();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favoritePlaces.isEmpty
          ? const Center(child: Text('No favorites yet!'))
          : ListView.builder(
              itemCount: favoritePlaces.length,
              itemBuilder: (context, index) {
                final place = favoritePlaces[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: BaseCard(
                      place: place,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
