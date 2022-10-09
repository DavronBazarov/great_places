import 'dart:io';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });
}

class Place {
  String id;
  String title;
  final PlaceLocation? location;
  final File image;

  Place({
    required this.id,
    required this.title,
    this.location,
    required this.image,
  });
}
