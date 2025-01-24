import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
class BaseCard extends StatefulWidget {
  final Map<String, dynamic> place;

  const BaseCard({super.key, required this.place});

  @override
  State<BaseCard> createState() => _BaseCardState();
}

class _BaseCardState extends State<BaseCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.place['isFavorite'] ?? false; // Default to false if not set
  }

  Future<void> _toggleFavorite() async {
    setState(() {
      isFavorite = !isFavorite;
    });

    // Update SharedPreferences with the new favorite state
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? placesData = prefs.getString('places');
    if (placesData != null) {
      List<Map<String, dynamic>> places =
      List<Map<String, dynamic>>.from(json.decode(placesData));

      // Find the place by its unique name
      final int placeIndex = places.indexWhere((p) => p['name'] == widget.place['name']);
      if (placeIndex != -1) {
        places[placeIndex]['isFavorite'] = isFavorite; // Update favorite state
        await prefs.setString('places', json.encode(places));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.place['name'],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                widget.place['imageUrl'],
                fit: BoxFit.cover,
              ),
            ),
            _buildGradient(),
            _buildTitleAndSubtitle(widget.place['name'], widget.place['governorate']),
            Positioned(
              right: 10,
              top: 10,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: _toggleFavorite,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return const Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleAndSubtitle(String name, String governorate) {
    return Positioned(
      left: 20,
      bottom: 20,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            governorate,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
