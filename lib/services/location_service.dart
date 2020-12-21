import 'dart:async';

import 'package:amadis_delivery/models/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class LocationService {
  LocationService() {
    selectedLocation = BehaviorSubject<Location>.seeded(null);
  }

  // final _dio = Dio();

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

  // String
  // static const _apiKey =
  //     'pk.eyJ1IjoiYWxmYWxmYTI3IiwiYSI6ImNrZmFidWtqOTA3MXcyeG9nYTlnN2VocjcifQ.Y7rvXSuCyuPwLMkiHenDkQ';
  // static const _BASE_URL_PLACES = 'https://api.mapbox.com/geocoding/v5';
  // static const _BASE_URL_ROUTES = 'https://api.mapbox.com/directions/v5';

  // Debouncer
  // final _debouncer = Debouncer<String>(duration: Duration(milliseconds: 400));
  // final StreamController<SearchResponse> _suggestionsStreamController =
  //     StreamController<SearchResponse>.broadcast();
  // Stream<SearchResponse> get suggestionsStream =>
  //     _suggestionsStreamController.stream;

  // Future<SearchResponse> getPlacesByQuery(
  //     String query, LatLng proximityPoint) async {
  //   try {
  //     final _endpoint = '$_BASE_URL_PLACES/mapbox.places/$query Peru.json';
  //     final _params = <String, dynamic>{
  //       'access_token': _apiKey,
  //       'autocomplete': 'true',
  //       'country': 'pe',
  //       'proximity': '${proximityPoint.longitude},${proximityPoint.latitude}',
  //       'language': 'es',
  //     };
  //     final response = await _dio.get(_endpoint,
  //         queryParameters: _params, options: dioOptions);
  //     return searchResponseFromJson(response.data);
  //   } catch (e) {
  //     print('Not this time: ' + e.toString());
  //     return null;
  //   }
  // }

  // Future<DrivingResponse> getRouteByPosition(
  //     LatLng origin, LatLng target) async {
  //   final position =
  //       '${origin.longitude},${origin.latitude};${target.longitude},${target.latitude}';
  //   final _url = '$_BASE_URL_ROUTES/mapbox/driving/$position';

  //   final response = await _dio.get(_url, queryParameters: {
  //     'alternatives': 'true',
  //     'geometries': 'polyline6',
  //     'steps': 'false',
  //     'access_token': _apiKey,
  //     'language': 'es',
  //   });

  //   final data = DrivingResponse.fromJson(response.data);
  //   return data;
  // }

  // void getSuggestionsByQuery(String query, LatLng proximity) {
  //   _debouncer.value = '';
  //   _debouncer.onValue = (value) async {
  //     final results = await getPlacesByQuery(query, proximity);
  //     _suggestionsStreamController.add(results);
  //   };

  //   final timer = Timer.periodic(
  //       Duration(milliseconds: 200), (_) => _debouncer.value = query);
  //   Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  // }
}
