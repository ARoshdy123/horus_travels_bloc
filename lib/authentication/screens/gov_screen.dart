import 'package:flutter/material.dart';

import 'widgets/main_widgets/gov_places.dart';

class GovernmentsPage extends StatelessWidget {
  final List<String> governorates = ["Cairo", "Alexandria", "Luxor"];

  GovernmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Governorates')),
      body: ListView.builder(
        itemCount: governorates.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(governorates[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlacesByGovernorate(
                    governorate: governorates[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
