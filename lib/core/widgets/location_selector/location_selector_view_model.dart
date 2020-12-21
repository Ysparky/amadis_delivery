import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/utils/service_injector.dart';
import 'package:amadis_delivery/models/location.dart';
import 'package:amadis_delivery/services/location_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationSelectorViewModel extends AmadisViewModel {
  CameraPosition get cameraPosition => CameraPosition(
        target: LatLng(-12.128826, -77.001422),
        zoom: 16,
      );

  final _locationService = injector<LocationService>();

  var _selectedPosition = LatLng(-12.128826, -77.001422);

  String _selectedAddress = '';
  String get selectedAddress => _selectedAddress;

  // void goBack() {
  //   _locationService.selectedLocation.add(null);
  //   ExtendedNavigator.root.pop();
  // }

  void saveLocation() {
    final location = Location(
      address: _selectedAddress,
      coordinates: _selectedPosition,
    );
    _locationService.selectedLocation.add(location);
    ExtendedNavigator.root.pop(location);
  }

  void updateSelectedPosition(CameraPosition cameraPosition) {
    _selectedPosition = cameraPosition.target;
  }

  void updateAddressFromSelectedLocation() async {
    _selectedAddress =
        await _locationService.getAddressFromCoords(_selectedPosition);
    notifyListeners();
  }
}
