import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PlaceService {
  final SharedPreferences prefs;

  PlaceService(this.prefs);

  Future<void> initializePlaces() async {
    if (!prefs.containsKey('places')) {
      await prefs.setString('places', json.encode([
        {
          "governorate": "Cairo",
          "imageUrl": "gimages/Pyramid.jpg",
          "name": "Pyramids of Giza",
          "isFavorite": false
        },
        {
          "governorate": "Cairo",
          "imageUrl": "gimages/gmm.png",
          "name": "The Grand Egyptian Museum",
          "isFavorite": false
        },
        {
          "governorate": "Cairo",
          "imageUrl": "gimages/tower.jpg",
          "name": "Cairo Tower",
          "isFavorite": false
        },
        {
          "governorate": "Cairo",
          "imageUrl": "gimages/salah.jpg",
          "name": "Salah El-Din's Citadel",
          "isFavorite": false
        },
        {
          "governorate": "Alexandria",
          "imageUrl":"gimages/BiAlexandria.jpg",
          "name": "Bibliotheque of Alexandria",
          "isFavorite": false
        },
        {
          "governorate": "Alexandria",
          "imageUrl":"gimages/Stanley Bridge.jpg",
          "name": "Stanley Bridge",
          "isFavorite": false
        },
        {
          "governorate": "Alexandria",
          "imageUrl":"gimages/castle.jpg",
          "name": "Citadel of Qaitbay",
          "isFavorite": false
        },
        {
          "governorate": "Luxor",
          "imageUrl":"gimages/Temple of Hatshepsut.jpg",
          "name": "Temple of Hatshepsut",
          "isFavorite": false
        },
        {
          "governorate": "Luxor",
          "imageUrl":"gimages/Temple of Luxor.jpg",
          "name": "Temple of Luxor",
          "isFavorite": false
        }
      ]));
    }
  }

  Future<List<Map<String, dynamic>>> loadPlaces() async {
    final String? placesData = prefs.getString('places');
    if (placesData != null) {
      return List<Map<String, dynamic>>.from(json.decode(placesData));
    } else {
      return [];
    }
  }
}
