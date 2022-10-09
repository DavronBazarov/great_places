import 'package:flutter/material.dart';
import 'package:flutter_complate_guide/providers/great_places.dart';
import 'package:flutter_complate_guide/screns/add_places_screen.dart';
import 'package:flutter_complate_guide/screns/place_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Places"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  builder: (ctx, greatPlaces, child) => greatPlaces
                          .items.isEmpty
                      ? const Center(
                          child: Text('Got no places yet , start adding some!'),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 3 / 3,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0),
                          itemCount: greatPlaces.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[index].id);
                                },
                                child: GridTile(
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        greatPlaces.items[index].image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        bottom: 5,
                                        right: 0,
                                        child: Container(
                                          width: 150,
                                          color: Colors.black54,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                greatPlaces.items[index].title,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ),
                                              Text(
                                                greatPlaces.items[index]
                                                    .location!.address
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 6,
                                                    color: Colors.white),
                                                softWrap: true,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ), //just for testing, will fill with image later
                                ),
                              ),
                            );
                          },
                        )),
        ));
  }
}
