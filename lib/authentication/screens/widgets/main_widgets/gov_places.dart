import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:horus_travels_bloc/authentication/screens/widgets/main_widgets/base_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlacesByGovernorate extends StatefulWidget {
  final String governorate;

  const PlacesByGovernorate({super.key, required this.governorate});

  @override
  State<PlacesByGovernorate> createState() => _PlacesByGovernorateState();
}

class _PlacesByGovernorateState extends State<PlacesByGovernorate> {
  List<Map<String, dynamic>> places = [];

  @override
  void initState() {
    super.initState();
    _initializePlaces();
  }

  Future<void> _initializePlaces() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('places')) {
      await prefs.setString(
        'places',
        json.encode([
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
        ]),
      );
    }

    final String? placesData = prefs.getString('places');
    if (placesData != null) {
      final List<Map<String, dynamic>> allPlaces =
      List<Map<String, dynamic>>.from(json.decode(placesData));

      setState(() {
        places = allPlaces
            .where((place) => place['governorate'] == widget.governorate)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Places in ${widget.governorate}')),
      body: places.isEmpty
          ? const Center(child: Text('No places found!'))
          : ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BaseCard(place: place),
            ),
          );
        },
      ),
    );
  }
}
