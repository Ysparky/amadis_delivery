import 'dart:convert';

import 'package:amadis_delivery/core/utils/key.dart';
import 'package:amadis_delivery/core/utils/utils.dart';
import 'package:amadis_delivery/models/models.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart' as ws;

class MapRouteViewModel extends AmadisViewModel {
  MapRouteViewModel(this.myRoute) {
    _initCameraPosition();
    _initMarkers();
    _getRoute();
  }

  final MyRoute myRoute;
  final _originPosition = LatLng(-12.1377804, -76.9527830);
  final _googleMapsDirections = ws.GoogleMapsDirections(
    apiKey: GOOGLE_API_KEY,
  );

  final _allMarkers = <Marker>[];
  List<Marker> get allMarkers => _allMarkers;

  Set<Polyline> _route = {};
  Set<Polyline> get currentRoute => _route;

  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;

  void goBack() => ExtendedNavigator.root.pop();

  void _initCameraPosition() {
    _cameraPosition = CameraPosition(
      target: _originPosition,
      zoom: 15,
    );
  }

  void _initMarkers() {
    _allMarkers.add(Marker(
      markerId: MarkerId('OriginMarker'),
      draggable: false,
      position: _originPosition,
      visible: true,
    ));

    myRoute.orders.forEach((order) {
      _allMarkers.add(
        Marker(
          markerId: MarkerId('Marker${order.id}'),
          draggable: false,
          position: order.location.coordinates,
          visible: true,
        ),
      );
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(jsonEncode(blueGrayMapTheme));
  }

  ws.Location _convertLatLngToLocation(LatLng position) {
    return ws.Location(position.latitude, position.longitude);
  }

  List<ws.Waypoint> _getAllWaypoints() {
    final waypoints = <ws.Waypoint>[];
    myRoute.orders.forEach((order) {
      print(order.location.coordinates.toString());
      if (order.id != myRoute.orders.last.id) {
        final coord = order.location.coordinates;
        final newLocation = ws.Location(coord.latitude, coord.longitude);
        final newWaypoint = ws.Waypoint.fromLocation(newLocation);
        waypoints.add(newWaypoint);
      }
    });
    return waypoints;
  }

  void _getRoute() async {
    setLoading(true);
    final origin = _convertLatLngToLocation(_originPosition);
    final destination = _convertLatLngToLocation(
      myRoute.orders.last.location.coordinates,
    );
    final waypoints = _getAllWaypoints();

    final response = await _googleMapsDirections.directionsWithLocation(
      origin,
      destination,
      waypoints: waypoints,
      travelMode: ws.TravelMode.driving,
      trafficModel: ws.TrafficModel.optimistic,
      language: 'es-419',
      departureTime: 'now',
    );
    setLoading(false);

    var newRoute = <Polyline>{};

    if (response.isOkay) {
      var route = response.routes[0];
      var idx = 0;
      for (var leg in route.legs) {
        var points = <LatLng>[];
        leg.steps.forEach((step) {
          points.add(LatLng(step.startLocation.lat, step.startLocation.lng));
          points.add(LatLng(step.endLocation.lat, step.endLocation.lng));
        });
        var line = Polyline(
          points: points,
          polylineId: PolylineId('Polyline$idx'),
          color: AmadisColors.errorColor,
          width: 4,
        );
        newRoute.add(line);
        idx++;
      }
      _route = newRoute;
      notifyListeners();
    } else {
      print('ERRROR !!! ${response.status}');
    }
  }
}
