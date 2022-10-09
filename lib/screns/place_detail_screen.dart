import 'package:flutter/material.dart';
import 'package:flutter_complate_guide/models/place.dart';
import 'package:flutter_complate_guide/providers/great_places.dart';
import 'package:flutter_complate_guide/screns/map_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';

  const PlaceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(
      context,
      listen: false,
    ).findById(id.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            selectedPlace.location!.address.toString(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffAB47BC),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (ctx) => MapScreen(
                          initialLocation:
                              (selectedPlace.location) as PlaceLocation,
                          isSelecting: false,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('View on Map'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
