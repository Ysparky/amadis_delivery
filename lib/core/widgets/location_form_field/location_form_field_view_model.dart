import 'package:amadis_delivery/core/config/config.dart';
import 'package:flutter/cupertino.dart';

class LocationFormFieldViewModel extends AmadisViewModel {
  LocationFormFieldViewModel({
    @required this.textController,
  });
  final TextEditingController textController;

  void openLocationModal(BuildContext context) async {}
}
