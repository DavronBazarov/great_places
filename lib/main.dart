import 'package:flutter/material.dart';
import 'package:flutter_complate_guide/providers/great_places.dart';
import 'package:flutter_complate_guide/screns/add_places_screen.dart';
import 'package:flutter_complate_guide/screns/place_detail_screen.dart';
import 'package:flutter_complate_guide/screns/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Great Places',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Color(0xffAB47BC),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => const PlaceDetailScreen(),
        },
      ),
    );
  }
}
