import 'package:amadis_delivery/core/config/config.dart';
import 'package:amadis_delivery/core/widgets/location_selector/location_selector.dart';
import 'package:amadis_delivery/models/location.dart';
import 'package:flutter/material.dart';

class LocationFormFieldViewModel extends AmadisViewModel {
  LocationFormFieldViewModel({
    @required this.textController,
  });
  final TextEditingController textController;

  void openLocationModal(BuildContext context) async {
    final location = await showDialog<Location>(
      context: context,
      builder: (_) => LocationSelector(),
    );
    if (location != null) {
      textController.text = location.address;
      notifyListeners();
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  String validator(String direccionValidator) {
    return direccionValidator.isNotEmpty ? null : 'Indica tu dirección';
  }
}
