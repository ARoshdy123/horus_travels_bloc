import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_hero_transform/local_hero_transform.dart';

import 'widgets/main_widgets/base_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ValueNotifier<FavoriteShape> _switchNotifier;
  List<Map<String, dynamic>> places = [];

  @override
  void initState() {
    super.initState();
    _switchNotifier = ValueNotifier(FavoriteShape.grid);
    _tabController = TabController(length: 2, vsync: this);
    _loadPlaces(); // Load places from SharedPreferences
  }

  Future<void> _loadPlaces() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? placesData = prefs.getString('places');
    if (placesData != null) {
      setState(() {
        places = List<Map<String, dynamic>>.from(json.decode(placesData));
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _switchBetweenGridAndList() {
    if (_switchNotifier.value == FavoriteShape.grid) {
      _tabController.animateTo(1);
      _switchNotifier.value = FavoriteShape.list;
    } else {
      _tabController.animateTo(0);
      _switchNotifier.value = FavoriteShape.grid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Popular Places'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildSwitchGridAndListButton(),
          ),
        ],
      ),
      body: LocalHero(
        controller: _tabController,
        pages: [
          ListViewContent(places: places),
          GridViewContent(places: places),
        ],
      ),
    );
  }

  Widget _buildSwitchGridAndListButton() {
    return ValueListenableBuilder(
      valueListenable: _switchNotifier,
      builder: (context, value, child) {
        return ConstrainedBox(
          constraints: BoxConstraints.tight(const Size(35, 35)),
          child: AspectRatio(
            aspectRatio: 1.9 / 2,
            child: RawMaterialButton(
              onPressed: _switchBetweenGridAndList,
              elevation: 0,
              visualDensity: const VisualDensity(
                vertical: -4,
                horizontal: -4,
              ),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1.2),
                borderRadius: BorderRadius.circular(5),
              ),
              fillColor: Colors.blue,
              child: Icon(
                _tabController.index == 0
                    ? Icons.grid_view_rounded
                    : Icons.view_agenda_outlined,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridViewContent extends StatelessWidget {
  final List<Map<String, dynamic>> places;

  const GridViewContent({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 16 / 21.5,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      padding: const EdgeInsets.all(20.0),
      children: List.generate(
        places.length,
            (index) => BaseCard( place: places[index]),
      ),
    );
  }
}

class ListViewContent extends StatelessWidget {
  final List<Map<String, dynamic>> places;

  const ListViewContent({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: places.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BaseCard( place: places[index]),
          ),
        );
      },
    );
  }
}


enum FavoriteShape { grid, list }
