import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  const Location({
    this.address,
    this.reference,
    this.coordinates,
  });

  final String address;
  final String reference;
  final LatLng coordinates;
}
