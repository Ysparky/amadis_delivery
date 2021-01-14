import 'dart:async';

import 'package:amadis_delivery/models/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  LocationService() {
    selectedLocation = BehaviorSubject<Location>.seeded(null);
  }

  BehaviorSubject<Location> selectedLocation;

  Future<String> getAddressFromCoords(LatLng position) async {
    final coords = Coordinates(position.latitude, position.longitude);
    final addressList =
        await Geocoder.local.findAddressesFromCoordinates(coords);
    final address = addressList.first;

    var validAddress =
        address.thoroughfare != null && address.thoroughfare.isNotEmpty;
    var validNumber =
        address.subThoroughfare != null && address.subThoroughfare.isNotEmpty;

    if (validAddress && validNumber) {
      return '${address.thoroughfare} ${address.subThoroughfare}';
    } else if (validAddress && !validNumber) {
      return '${address.thoroughfare}';
    } else {
      return null;
    }
  }
}
