import 'package:amadis_delivery/core/config/colors.dart';
import 'package:amadis_delivery/core/config/loading_overlay.dart';
import 'package:amadis_delivery/core/utils/responsive.dart';
import 'package:amadis_delivery/core/widgets/custom_button.dart';
import 'package:amadis_delivery/core/widgets/location_selector/location_selector_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationSelectorViewModel()),
      ],
      child: LoadingOverlay<LocationSelectorViewModel>(
        child: LocationSelectorBase(),
      ),
    );
  }
}

class LocationSelectorBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _viewModel = Provider.of<LocationSelectorViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AmadisColors.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: null,
        ),
        centerTitle: true,
        title: Text(_viewModel.selectedAddress ?? 'Dirección no encontrada'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _viewModel.cameraPosition,
            myLocationEnabled: false,
            onCameraMove: _viewModel.updateSelectedPosition,
            onCameraIdle: () async =>
                _viewModel.updateAddressFromSelectedLocation(),
          ),
          Center(
            child: Transform.translate(
              offset: Offset(0, -12),
              child: Icon(
                Icons.location_on,
                color: AmadisColors.errorColor,
                size: 48.0,
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: _viewModel.selectedAddress == null ? -100 : hp(5),
            duration: const Duration(seconds: 1),
            child: CustomButton(
              onPressed: _viewModel.saveLocation,
              text: 'CONFIRMAR',
            ),
          ),
        ],
      ),
    );
  }
}
